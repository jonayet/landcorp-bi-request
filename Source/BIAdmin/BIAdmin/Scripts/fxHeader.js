/*
*	@Author Jaimon Mathew www.jaimon.co.uk
*  Please see http://jaimonmathew.wordpress.com/2010/03/19/making-scrollable-tables-with-fixed-headers-updated-2/
*/
(
    function () {
        var l = false, e = [];
        this.ge$ = function (a) {
            return document.getElementById(a)
        };
        this.scrollHeader = function (a) {
            if (!l) {
                a = a ? a : window.event;
                a = a.target ? a.target : a.srcElement;
                if (a.nodeType == 3) a = a.parentNode;
                var b = a.id.replace(":scroller", ""), g = ge$(b + ":scroller:fx");
                a = ge$(b + ":scroller");
                g.style.left = 0 - a.scrollLeft + "px";
                if (b = ge$(b + "_CFB")) {
                    g = parseInt(b.getAttribute("dmt"));
                    b.style.marginTop = 0 - (a.scrollTop + g) + "px"
                }
            }
        };
        this.fxheader = function () {
            if (!l) {
                l = true;
                for (var a = 0; a < e.length; a++) {
                    var b = ge$(e[a].tid), g = e[a].swidth + "";
                    var i = ge$(e[a].tid + ":scroller:fx");
                    if (i != null) {
                        if (g.indexOf("%") >= 0) {
                            i.style.width = "0px";
                            g = parseInt(g);
                            g = (document.body.offsetWidth ? document.body.offsetWidth : window.innerWidth) * g / 100;
                            i.style.width = "9999px"
                        }
                        b.style.width = parseInt(g - 18) + "px";
                        i.style.marginLeft = "0px";
                        i.style.display = "";
                        var d = i.childNodes, c;
                        for (c = 0; c < d.length; c++)
                            i.removeChild(d[c]);
                        var f = b.cloneNode(false);
                        f.id = e[a].tid + "__cN";
                        f.style.width = document.all ? b.offsetWidth + "px" : "auto";
                        f.style.marginTop = "0px";
                        f.style.marginLeft = "0px";
                        d = document.createElement("thead");
                        d.style.padding = "0px";
                        d.style.margin = "0px";
                        for (c = 0; c < e[a].noOfRows; c++) {
                            var h = b.rows[c].cloneNode(true);
                            d.appendChild(h)
                        }
                        f.appendChild(d);
                        i.appendChild(f);
                        var k;
                        if (e[a].noOfCols > 0) {
                            k = f.cloneNode(true);
                            k.id = e[a].tid + "_CFH"
                        }
                        for (c = d = 0; c < e[a].noOfRows; c++) {
                            h = f.rows[c].cells;
                            var m, n = b.rows[c].cells, j;
                            if (k) {
                                m = k.rows[c].cells;
                                for (j = 0; j < h.length; j++) {
                                    if (n[j].offsetWidth == "" || n[j].offsetWidth == 0) {
                                        h[j].style.width = m[j].style.width = "0px";
                                    }
                                    else {
                                        h[j].style.width = m[j].style.width = n[j].offsetWidth - 3 + "px";
                                    }
                                }
                            }
                            else for (j = 0; j < h.length; j++)
                                if (n[j].offsetWidth == "" || n[j].offsetWidth == 0) {
                                    h[j].style.width = "0px";
                                }
                                else {
                                    h[j].style.width = n[j].offsetWidth - 3 + "px";
                                }
                            d += b.rows[c].offsetHeight
                        }
                        b.style.marginTop = "-" + d + "px";
                        f = e[a].sheight;
                        if (b.offsetHeight < f)
                            f = b.offsetHeight + 18;
                        h = 0;
                        if (e[a].noOfCols > 0) {
                            for (c = 0; c < e[a].noOfCols; c++)
                                h += b.rows[0].cells[c].offsetWidth;
                            b.style.marginLeft = "-" + h + "px";
                            b.style.display = "block";
                            i.style.marginLeft = "-" + h + "px";
                            ge$(e[a].tid + ":scroller:fxcol").style.width = h + "px";
                            c = ge$(e[a].tid + ":scroller:fxCH");
                            i = ge$(e[a].tid + ":scroller:fxCB");
                            c.innerHTML = "";
                            i.innerHTML = "";
                            c.appendChild(k);
                            c.style.height = d + "px";
                            i.style.height = f - d + "px";
                            b = b.cloneNode(true);
                            b.id = e[a].tid + "_CFB";
                            b.style.marginLeft = "0px";
                            b.setAttribute("dmt", d);
                            i.appendChild(b)
                        }
                        g = parseInt(g) - h + "px";
                        ge$(e[a].tid + ":scroller").style.height = f - d + "px";
                        ge$(e[a].tid + ":scroller").style.width = g;
                        ge$(e[a].tid + ":scroller:fx:OuterDiv").style.height = d + "px";
                        ge$(e[a].tid + ":scroller:fx:OuterDiv").style.width = g
                    }
                }
                    window.onresize = fxheader; l = false
            }
        };
        this.fxheaderInit = function (a, b, g, i, w) {
            var d = {}, c = ge$(a);
            d.tid = a;
            d.sheight = b;
            d.swidth = w;
            if (!d.swidth || d.swidth.length == 0) {
                d.swidth = c.style.width;
                if (!d.swidth)
                    d.swidth = "100%";
                if (d.swidth.indexOf("%") == -1)
                    d.swidth = parseInt(d.swidth)
            }
            d.noOfRows = g;
            d.noOfCols = i;
            if (!ge$(a + ":scroller")) {
                var f = ge$(a);
                b = f.parentNode;
                g = f.nextSibling;
                c = document.createElement("div");
                c.id = a + ":scroller";
                c.style.cssText = "height:auto;overflow-x:auto;overflow-y:auto;width:auto;";
                c.onscroll = scrollHeader;
                c.appendChild(f);
                f = document.createElement("div");
                f.id = a + ":scroller:fx:OuterDiv";
                f.style.cssText = "position:relative;width:auto;overflow:hidden;overflow-x:hidden;padding:0px;margin:0px;";
                f.innerHTML = '<div id="' + a + ':scroller:fx" style="text-align:center;position:relative;width:9999px;padding:0px;margin-left:0px;"><font size="3" color="red">Please wait while loading the table..</font></div>';
                var h = null;
                if (i > 0) {
                    h = document.createElement("div");
                    h.id = a + ":scroller:fxcol";
                    h.style.cssText = "width:0px;height:auto;display:block;float:left;overflow:hidden;";
                    h.innerHTML = "<div id='" + a + ":scroller:fxCH' style='width:100%;overflow:hidden;'>&nbsp;</div><div id='" + a + ":scroller:fxCB' style='width:100%;overflow:hidden;'>&nbsp;</div>"
                }
                if (g) {
                    h && b.insertBefore(h, g);
                    b.insertBefore(f, g);
                    b.insertBefore(c, g)
                }
                else {
                    h && b.appendChild(h);
                    b.appendChild(f);
                    b.appendChild(c)
                }
            }
            e[e.length] = d
        }
    })();