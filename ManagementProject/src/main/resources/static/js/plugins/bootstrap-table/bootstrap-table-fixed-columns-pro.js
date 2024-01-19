/**
 * @author rioli <cjtty2@gmail.com>
 * @version: v1.0.1
 */

(function ($) {
    'use strict';

    $.extend($.fn.bootstrapTable.defaults, {
        fixedColumns: false,
        fixedNumber: 1,
        fixedFrom: 'left'
    });

    var BootstrapTable = $.fn.bootstrapTable.Constructor,
        _initHeader = BootstrapTable.prototype.initHeader,
        _initBody = BootstrapTable.prototype.initBody,
        _resetView = BootstrapTable.prototype.resetView;

    BootstrapTable.prototype.initFixedColumns = function () {
        this.$fixedHeader = $([
            '<div class="fixed-table-header-columns">',
            '<table>',
            '<thead></thead>',
            '</table>',
            '</div>'].join(''));

        this.timeoutHeaderColumns_ = 0;
        this.$fixedHeader.find('table').attr('class', this.$el.attr('class'));
        this.$fixedHeaderColumns = this.$fixedHeader.find('thead');
        this.$tableHeader.before(this.$fixedHeader);

        this.$fixedBody = $([
            '<div class="fixed-table-body-columns">',
            '<table>',
            '<tbody></tbody>',
            '</table>',
            '</div>'].join(''));

        this.timeoutBodyColumns_ = 0;
        this.$fixedBody.find('table').attr('class', this.$el.attr('class'));
        this.$fixedBodyColumns = this.$fixedBody.find('tbody');
        this.$tableBody.before(this.$fixedBody);
        if (this.options.fixedFrom == 'right') {
            this.$fixedHeader.css({ right: 0,"z-index":9999 });
            this.$fixedBody.css({ right: 0,"z-index":9999 })
        }
        
    };

    BootstrapTable.prototype.initHeader = function () {
        _initHeader.apply(this, Array.prototype.slice.apply(arguments));

        if (!this.options.fixedColumns) {
            return;
        }

        this.initFixedColumns();

        var that = this, $trs = this.$header.find('tr').clone();
        $trs.each(function () {
            if (that.options.fixedFrom == 'right') {
                var index = that.options.columns[0].length - Math.abs(parseInt(that.options.fixedNumber));
                $(this).find('th:lt(' + index + ')').remove();

            } else {
                $(this).find('th:gt(' + that.options.fixedNumber + ')').remove();
            }

        });
        this.$fixedHeaderColumns.html('').append($trs);
    };

    BootstrapTable.prototype.initBody = function () {
        _initBody.apply(this, Array.prototype.slice.apply(arguments));

        if (!this.options.fixedColumns) {
            return;
        }

        var that = this,
            rowspan = 0;

        this.$fixedBodyColumns.html('');
        this.$body.find('> tr[data-index]').each(function () {
            var $tr = $(this).clone(),
                $tds = $tr.find('td');

            $tr.html('');
            if (that.options.fixedFrom == 'right') {
                var end = that.options.columns[0].length - Math.abs(parseInt(that.options.fixedNumber));
            } else {
                var end = that.options.fixedNumber;
            }

            if (rowspan > 0) {
                --end;
                --rowspan;
            }
            if (that.options.fixedFrom == 'right') {
                for (var i = end; i < that.options.columns[0].length; i++) {
                    $tr.append($tds.eq(i).clone());
                }
            } else {
                for (var i = 0; i < end; i++) {
                    $tr.append($tds.eq(i).clone());
                }
            }

            that.$fixedBodyColumns.append($tr);

            if ($tds.eq(0).attr('rowspan')) {
                rowspan = $tds.eq(0).attr('rowspan') - 1;
            }
        });
    };

    BootstrapTable.prototype.resetView = function () {
        _resetView.apply(this, Array.prototype.slice.apply(arguments));

        if (!this.options.fixedColumns) {
            return;
        }

        clearTimeout(this.timeoutHeaderColumns_);
        this.timeoutHeaderColumns_ = setTimeout($.proxy(this.fitHeaderColumns, this), this.$el.is(':hidden') ? 100 : 0);

        clearTimeout(this.timeoutBodyColumns_);
        this.timeoutBodyColumns_ = setTimeout($.proxy(this.fitBodyColumns, this), this.$el.is(':hidden') ? 100 : 0);
    };

    BootstrapTable.prototype.fitHeaderColumns = function () {
        var that = this,
            visibleFields = this.getVisibleFields(),
            headerWidth = 0;
        if (that.options.fixedFrom == 'right') {
            var trs = [].slice.call(this.$body.find('tr:first-child:not(.no-records-found) > *'));
            var $trs = $(trs.reverse());
            $trs.each(function (i) {
                var $this = $(this);
                var index = i;
                if (i >= Math.abs(that.options.fixedNumber)) {
                    return false;
                }

                if (that.options.detailView && !that.options.cardView) {
                    index = i - 1;
                }
                that.$fixedHeader.find('th[data-field="' + visibleFields[$trs.length - 1 + index] + '"]')
                    .find('.fht-cell').width($this.innerWidth());
                headerWidth += $this.outerWidth();
            });
            that.$header.find('> tr').each(function (i) {
              that.$fixedHeader.height($(this).height());
            });
        } else {
            this.$body.find('tr:first-child:not(.no-records-found) > *').each(function (i) {
                var $this = $(this),
                    index = i;
                if (i >= that.options.fixedNumber) {
                    return false;
                }
                if (that.options.detailView && !that.options.cardView) {
                    index = i - 1;
                }
                that.$fixedHeader.find('th[data-field="' + visibleFields[index] + '"]')
                    .find('.fht-cell').width($this.innerWidth());
                headerWidth += $this.outerWidth();
            });
        }
        this.$fixedHeader.width(headerWidth + 1).show();
    };
    
    function isnotIE(){
    	if (!!window.ActiveXObject || "ActiveXObject" in window||navigator.userAgent.indexOf("Edge") > -1)
    		  return false;
    		  else
    		  return true;
    	}

    BootstrapTable.prototype.fitBodyColumns = function () {
        var that = this,
            top = -(parseInt(this.$el.css('margin-top')) - (isnotIE()? 1:-1)),
            // the fixed height should reduce the scorll-x height
            height = this.$tableBody.height() - (isnotIE()? 18:30);
            console.log("fitBodyColumns" + height);
            
            var obj=document.getElementsByClassName("fixed-table-body"); 
            
            if (this.options.fixedFrom == 'right') {
            	if(obj[0].scrollHeight>obj[0].offsetHeight){ 
                        this.$fixedHeader.css({ right: 6,"z-index":9999 });
                        this.$fixedBody.css({ right: 6,"z-index":9999 })
                 }else{
                         this.$fixedHeader.css({ right: 0,"z-index":9999 });
                         this.$fixedBody.css({ right: 0,"z-index":9999 })
                 } 
            }
            
           

        if (!this.$body.find('> tr[data-index]').length) {
            this.$fixedBody.hide();
            return;
        }

        if (!this.options.height) {
            top = this.$fixedHeader.height();
            console.log("fitBodyColumns header Height" + top);
            height = height - top;
        }

        // height = this.$tableBody.find("tbody").height();
        this.$fixedBody.css({
            width: this.$fixedHeader.width(),
            height: height+12,
            top: top
        }).show();

        this.$body.find('> tr').each(function (i) {
            that.$fixedBody.find('tr:eq(' + i + ')').height($(this).height());
        });

        // events
        this.$tableBody.on('scroll', function () {
            that.$fixedBody.find('table').css('top', -$(this).scrollTop());
        });
        this.$body.find('> tr[data-index]').off('hover').hover(function () {
            var index = $(this).data('index');
            that.$fixedBody.find('tr[data-index="' + index + '"]').addClass('hover');
        }, function () {
            var index = $(this).data('index');
            that.$fixedBody.find('tr[data-index="' + index + '"]').removeClass('hover');
        });
        this.$fixedBody.find('tr[data-index]').off('hover').hover(function () {
            var index = $(this).data('index');
            that.$body.find('tr[data-index="' + index + '"]').addClass('hover');
        }, function () {
            var index = $(this).data('index');
            that.$body.find('> tr[data-index="' + index + '"]').removeClass('hover');
        });
        fixFixedRightColumnsEvents.call(this);
    };

    function fixFixedRightColumnsEvents() {
        var that = this;
        if (this.options.fixedFrom == 'right') {
            var fixedBeginIndex = that.options.columns[0].length - 1 - that.options.fixedNumber;
            $.each(this.header.events, function (i, events) {
                if (i < fixedBeginIndex) {
                    return;
                }
                if (!events) {
                    return;
                }
                // fix bug, if events is defined with namespace
                if (typeof events === 'string') {
                    events = calculateObjectValue(null, events);
                }

                var field = that.header.fields[i];
                var fieldIndex = $.inArray(field, that.getVisibleFields());

                if (fieldIndex === -1) {
                    return;
                }

                if (that.options.detailView && !that.options.cardView) {
                    fieldIndex += 1;
                }

                for (var key in events) {
                    that.$fixedBodyColumns.find('>tr:not(.no-records-found)').each(function () {
                        var $tr = $(this),
                            $td = $tr.find(that.options.cardView ? '.card-view' : 'td').eq(fieldIndex - fixedBeginIndex - 1),
                            index = key.indexOf(' '),
                            name = key.substring(0, index),
                            el = key.substring(index + 1),
                            func = events[key];

                        $td.find(el).off(name).on(name, function (e) {
                            var index = $tr.data('index'),
                                row = that.data[index],
                                value = row[field];

                            func.apply(this, [e, value, row, index]);
                        });
                    });
                }
            });
        }

    }

})(jQuery);
