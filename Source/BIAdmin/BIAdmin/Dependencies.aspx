<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Dependencies.aspx.cs" Inherits="BIAdmin.Dependencies" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
    </asp:ScriptManagerProxy>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="jqwidgets/jqx-all.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxdata.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxlistbox.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxdropdownlist.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxdatatable.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxwindow.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxvalidator.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxinput.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxnumberinput.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxdatetimeinput.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.sort.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.pager.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.selection.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.edit.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxcombobox.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxdata.export.js"></script>
    <script type="text/javascript">

        var _MainObjectType = "BASE TABLE";
        var _MainObjectServer = "RPT-PW1";
        var _MainObjectCatalog = "Landcorp_Reporting";
        var _MainObjectSchema = "dbo";
        var _MainObjectName = "";

        var _divMainObjectType;
        var _divMainObjectServer;
        var _divMainObjectCatalog;
        var _divMainObjectSchema;

        var _HasTrigger = false;
        var _TriggerObjectType = "";
        var _TriggerObjectServer = "";
        var _TriggerObjectCatalog = "";
        var _TriggerObjectSchema = "";
        var _TriggerObjectName = "";

        var _LastObjectType = "";
        var _LastObjectServer = "";
        var _LastObjectCatalog = "";
        var _LastObjectSchema = "";

        var _mainDataAdapter;
        var _maxItems = 14;

        $(document).ready(function () {
            _divMainObjectType = $('#divMainObjectType').jqxDropDownList({ width: '200', dropDownWidth: '350', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData' });
            _divMainObjectServer = $('#divMainObjectServer').jqxDropDownList({ width: '175', dropDownWidth: '350', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData' });
            _divMainObjectCatalog = $('#divMainObjectCatalog').jqxDropDownList({ width: '250', dropDownWidth: '350', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData' });
            _divMainObjectSchema = $('#divMainObjectSchema').jqxDropDownList({ width: '200', dropDownWidth: '350', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData' });

            _divMainObjectType.on('select', function () {
                _MainObjectType = _divMainObjectType.val();
                GetObjectServer('dd', _divMainObjectServer, _MainObjectType, true, 0, function () { setDDValue(_divMainObjectServer, _MainObjectServer); });
            });

            _divMainObjectServer.on('select', function () {
                _MainObjectServer = _divMainObjectServer.val();
                GetObjectCatalog('dd', _divMainObjectCatalog, _MainObjectType, _MainObjectServer, true, 0, function () { setDDValue(_divMainObjectCatalog, _MainObjectCatalog); });
            });

            _divMainObjectCatalog.on('select', function () {
                _MainObjectCatalog = _divMainObjectCatalog.val();
                GetObjectSchema('dd', _divMainObjectSchema, _MainObjectType, _MainObjectServer, _MainObjectCatalog, true, 0, function () { setDDValue(_divMainObjectSchema, _MainObjectSchema); });
            });

            _divMainObjectSchema.on('select', function () {
                _MainObjectSchema = _divMainObjectSchema.val();
                LoadGrid()
            });

            var NewObject = $("#divNewObject").jqxButton({ width: '100', height: '19' });
            NewObject.on('click', function () { showEditWindow(0, null); });

            var divDefaults = $("#divDefaults").jqxButton({ width: '100', height: '19' });
            divDefaults.on('click', function () { showDefaults(); });

            GetObjectType('dd', _divMainObjectType, true, '', 0, function () { setDDValue(_divMainObjectType, _MainObjectType); });

        });

        $(window).resize(function () {
            resizeTable();
        });

        function processWindow(action, index, window) {
            if (action == 'Add') {
                windows[index] = window;
            }
            else {
                windows.splice(index, 1)
            }
        }

        function finishDataRetrieval(targetType, target, da) {
            if (targetType == 'dd') {
                target.jqxDropDownList({ source: da });
            }
            else if (targetType == 'cb') {
                target.jqxComboBox({ source: da });
            }
            else {
                return da;
            }
        }

        function GetObjectType(targetType, target, IncludeSelectAll, IsSQLObject, ExcludeSK_ObjectId, loadComplete) {
            var source =
                {
                    datatype: 'xml',
                    datafields: [
                        { name: 'ObjectData', map: 'ObjectData', type: 'string' }
                    ],
                    root: 'NewDataSet',
                    record: 'Record',
                    url: 'Dependencies.aspx/GetObjectType',
                    data: {
                        IsSQLObject: '"' + IsSQLObject + '"',
                        IncludeSelectAll: '"' + IncludeSelectAll + '"',
                        ExcludeSK_ObjectId: '"' + ExcludeSK_ObjectId + '"'
                    }
                };

            var da = new $.jqx.dataAdapter(source, { contentType: 'application/json; charset=utf-8', loadComplete: loadComplete });

            finishDataRetrieval(targetType, target, da);
        }

        function GetObjectServer(targetType, target, ObjectType, IncludeSelectAll, ExcludeSK_ObjectId, loadComplete) {

            var source =
                {
                    datatype: 'xml',
                    datafields: [
                        { name: 'ObjectData', map: 'ObjectData', type: 'string' }
                    ],
                    root: 'NewDataSet',
                    record: 'Record',
                    url: 'Dependencies.aspx/GetObjectServer',
                    data: {
                        ObjectType: '"' + ObjectType + '"',
                        IncludeSelectAll: '"' + IncludeSelectAll + '"',
                        ExcludeSK_ObjectId: '"' + ExcludeSK_ObjectId + '"'
                    }
                };

            var da = new $.jqx.dataAdapter(source, { contentType: 'application/json; charset=utf-8', loadComplete: loadComplete });

            finishDataRetrieval(targetType, target, da);
        }

        function GetObjectCatalog(targetType, target, ObjectType, ObjectServer, IncludeSelectAll, ExcludeSK_ObjectId, loadComplete) {
            var source =
                {
                    datatype: 'xml',
                    datafields: [
                        { name: 'ObjectData', map: 'ObjectData', type: 'string' }
                    ],
                    root: 'NewDataSet',
                    record: 'Record',
                    url: 'Dependencies.aspx/GetObjectCatalog',
                    data: {
                        ObjectType: '"' + ObjectType + '"',
                        ObjectServer: '"' + ObjectServer + '"',
                        IncludeSelectAll: '"' + IncludeSelectAll + '"',
                        ExcludeSK_ObjectId: '"' + ExcludeSK_ObjectId + '"'
                    }
                };

            var da = new $.jqx.dataAdapter(source, { contentType: 'application/json; charset=utf-8', loadComplete: loadComplete });

            finishDataRetrieval(targetType, target, da);
        }

        function GetObjectSchema(targetType, target, ObjectType, ObjectServer, ObjectCatalog, IncludeSelectAll, ExcludeSK_ObjectId, loadComplete) {
            var source =
                {
                    datatype: 'xml',
                    datafields: [
                        { name: 'ObjectData', map: 'ObjectData', type: 'string' }
                    ],
                    root: 'NewDataSet',
                    record: 'Record',
                    url: 'Dependencies.aspx/GetObjectSchema',
                    data: {
                        ObjectType: '"' + ObjectType + '"',
                        ObjectServer: '"' + ObjectServer + '"',
                        ObjectCatalog: '"' + ObjectCatalog + '"',
                        IncludeSelectAll: '"' + IncludeSelectAll + '"',
                        ExcludeSK_ObjectId: '"' + ExcludeSK_ObjectId + '"'
                    }
                };

            var da = new $.jqx.dataAdapter(source, { contentType: 'application/json; charset=utf-8', loadComplete: loadComplete });

            finishDataRetrieval(targetType, target, da);
        }

        function GetObjectName(targetType, target, ObjectType, ObjectServer, ObjectCatalog, ObjectSchema, IncludeSelectAll, ExcludeSK_ObjectId, loadComplete) {
            var source =
                {
                    datatype: 'xml',
                    datafields: [
                        { name: 'ObjectData', map: 'ObjectData', type: 'string' }
                    ],
                    root: 'NewDataSet',
                    record: 'Record',
                    url: 'Dependencies.aspx/GetObjectName',
                    data: {
                        ObjectType: '"' + ObjectType + '"',
                        ObjectServer: '"' + ObjectServer + '"',
                        ObjectCatalog: '"' + ObjectCatalog + '"',
                        ObjectSchema: '"' + ObjectSchema + '"',
                        IncludeSelectAll: '"' + IncludeSelectAll + '"',
                        ExcludeSK_ObjectId: '"' + ExcludeSK_ObjectId + '"'
                    }
                };

            var da = new $.jqx.dataAdapter(source, { contentType: 'application/json; charset=utf-8', loadComplete: loadComplete });

            finishDataRetrieval(targetType, target, da);
        }

        function LoadGrid() {

            var SourceObjectOuter = $('#divSourceObjectOuter');
            SourceObjectOuter.empty();
            SourceObjectOuter.append($('<div id="divSourceObject"></div>'));

            SourceObject = SourceObjectOuter.find('#divSourceObject');

            var source =
                {
                    datatype: 'xml',
                    datafields: [
                        { name: 'SK_ObjectId', map: 'SK_ObjectId', type: 'number' },
                        { name: 'IsSQLObject', map: 'IsSQLObject', type: 'boolean' },
                        { name: 'ObjectType', map: 'ObjectType', type: 'string' },
                        { name: 'FullName', map: 'FullName', type: 'string' },
                        { name: 'ObjectId', map: 'ObjectId', type: 'number' },
                        { name: 'ObjectServer', map: 'ObjectServer', type: 'string' },
                        { name: 'ObjectCatalog', map: 'ObjectCatalog', type: 'string' },
                        { name: 'ObjectSchema', map: 'ObjectSchema', type: 'string' },
                        { name: 'ObjectName', map: 'ObjectName', type: 'string' }
                    ],
                    root: 'NewDataSet',
                    record: 'Record',
                    url: 'Dependencies.aspx/GetData',
                    id: 'SK_ObjectId',
                    data: {
                        ObjectType: '"' + _MainObjectType + '"',
                        ObjectServer: '"' + _MainObjectServer + '"',
                        ObjectCatalog: '"' + _MainObjectCatalog + '"',
                        ObjectSchema: '"' + _MainObjectSchema + '"'
                    }
                };

            _mainDataAdapter = new $.jqx.dataAdapter(source, { contentType: 'application/json; charset=utf-8', loadComplete: function () { } });

            SourceObject.jqxGrid(
            {
                width: 1205,
                source: _mainDataAdapter,
                pageable: false,
                columnsResize: false,
                scrollbarsize: 10,
                sortable: true,
                autoHeight: true,
                ready: function () {
                    resizeTable()
                },
                columns: [
                  { text: 'Object Type', dataField: 'ObjectType', minWidth: 100, width: 205 },
                  { text: 'Full Name', dataField: 'FullName', minWidth: 100, width: 985 }
                ]
            });

            SourceObject.on('rowdoubleclick', function (event) {
                var SK_ObjectId = SourceObject.jqxGrid('getrowid', args.rowindex);
                var data = SourceObject.jqxGrid('getrowdatabyid', SK_ObjectId);
                ShowDependancyWindow(SK_ObjectId, data.FullName, null)
            });

        }

        function resizeTable() {
            var maxheight = $(window).height() - 125;
            if (_mainDataAdapter != null) {
                var recordsHeight = _mainDataAdapter.records.length * 25 + 25;

                if (recordsHeight > maxheight) {
                    $('#divSourceObject').jqxGrid({ autoHeight: false, height: maxheight, width: 1205 });
                }
                else {
                    $('#divSourceObject').jqxGrid({ autoHeight: true, width: 1190 });
                }
            }
        }

        function setDDValue(object, valueToSet) {
            var matched = false;
            var items = object.jqxDropDownList('getItems');
            for (var i = 0; i < items.length; i++) {
                if (items[i].value == valueToSet) {
                    matched = true;
                    object.jqxDropDownList({ selectedIndex: i });
                }
            }

            if (!matched) {
                if (items.length == 1) {
                    object.jqxDropDownList({ selectedIndex: 0 });
                }
                else {
                    object.jqxDropDownList({ selectedIndex: -1 });
                }
            }

            var height = items.length * 25;

            if (items.length > _maxItems) {
                height = _maxItems * 25;
            }
            object.jqxDropDownList({ dropDownHeight: height });
        }

        function setCBValue(object, valueToSet) {
            var matched = false;
            var items = object.jqxComboBox('getItems');
            for (var i = 0; i < items.length; i++) {
                if (items[i].value == valueToSet) {
                    matched = true;
                    object.jqxComboBox({ selectedIndex: i });
                }
            }

            if (!matched) {
                if (items.length == 1) {
                    object.jqxComboBox({ selectedIndex: 0 });
                }
                else {
                    object.jqxComboBox({ selectedIndex: -1 });
                }
            }
        }

        function showEditWindow(SK_ObjectId, parentWindow) {
            var contents = '';
            contents += '<div id="divWindow">';
            contents += '   <div id="windowHeader">' + (SK_ObjectId == 0 ? 'New' : 'Edit') + ' Object</div>';
            contents += '   <div style="overflow: hidden;" id="windowContent">';
            contents += '       <table>';
            contents += '           <tr>';
            contents += '               <td>SQL Object:</td>';
            contents += '               <td>';
            contents += '                   <div id="divIsSQLObject"></div>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '           <tr>';
            contents += '               <td>TYPE:</td>';
            contents += '               <td>';
            contents += '                   <div id="divObjectType"></div>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '           <tr>';
            contents += '               <td>SERVER:</td>';
            contents += '               <td>';
            contents += '                   <div id="divObjectServer"></div>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '           <tr>';
            contents += '               <td>DATABASE:</td>';
            contents += '               <td>';
            contents += '                   <div id="divObjectCatalog"></div>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '           <tr>';
            contents += '               <td>SCHEMA:</td>';
            contents += '               <td>';
            contents += '                   <div id="divObjectSchema"></div>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '           <tr>';
            contents += '               <td>NAME:</td>';
            contents += '               <td>';
            contents += '                   <input type="text" id="divObjectName" />';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '       </table>';
            contents += '       <table>';
            contents += '           <tr>';
            contents += '               <td>';
            contents += '                   <div id="divSave">Save</div>';
            contents += '               </td>';
            contents += '               <td>';
            contents += '                   <div id="divSaveAndNew">Save & New</div>';
            contents += '               </td>';
            contents += '               <td>';
            contents += '                   <div id="divDelete">Delete</div>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '       </table>';
            contents += '   <div>';
            contents += '<div>';

            var window = $(contents).jqxWindow({
                showCollapseButton: true,
                maxHeight: 265,
                maxWidth: 615,
                minHeight: 200,
                minWidth: 200,
                height: 265,
                width: 615,
                isModal: true,
                showCollapseButton: false,
                resizable: false,
                draggable: false
            });

            var divDelete = window.find("#divDelete");
            divDelete.hide();

            window.on('close', function (event) {
                window.jqxValidator('hide');
                window.jqxWindow('destroy');
            });

            var SaveAndNew = false;

            var IsSQLObject = false;
            var ObjectType = "";
            var ObjectServer = "[ EMPTY ]";
            var ObjectCatalog = "[ EMPTY ]";
            var ObjectSchema = "[ EMPTY ]";
            var ObjectName = "";

            var divIsSQLObject = window.find('#divIsSQLObject').jqxSwitchButton({ width: 60, height: 25, onLabel: 'Yes', offLabel: 'No', thumbSize: '15px', checked: IsSQLObject });
            var divObjectType = window.find('#divObjectType').jqxComboBox({ width: '250', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData' });
            var divObjectServer = window.find('#divObjectServer').jqxComboBox({ width: '250', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData', disabled: true });
            var divObjectCatalog = window.find('#divObjectCatalog').jqxComboBox({ width: '250', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData', disabled: true });
            var divObjectSchema = window.find('#divObjectSchema').jqxComboBox({ width: '250', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData', disabled: true });
            var divObjectName = window.find('#divObjectName').jqxInput({ width: 500, height: 25 });

            if (SK_ObjectId != 0) {
                var da = getRecordData(SK_ObjectId, function () {
                    if (da.records.length == 1) {
                        var rec = da.records[0];
                        IsSQLObject = rec.IsSQLObject;
                        ObjectType = rec.ObjectType;
                        ObjectServer = rec.ObjectServer;
                        ObjectCatalog = rec.ObjectCatalog;
                        ObjectSchema = rec.ObjectSchema;
                        ObjectName = rec.ObjectName;

                        if (rec.ObjectId == "") {
                            divDelete.show();
                            divDelete.jqxButton({ width: '100', height: '19' });
                            divDelete.on('click', function () {
                                if (confirm('Are you sure?')) {
                                    PageMethods.DeleteObject(SK_ObjectId, ObjectDeleted, function (error) { alert(error); });
                                }
                            });
                        }
                        resetWindow();
                    }
                });
                da.dataBind();
            }

            divObjectType.on('select', function () {
                ObjectType = divObjectType.val();
                GetObjectServer('cb', divObjectServer, ObjectType, false, 0, function () { setCBValue(divObjectServer, ObjectServer); });
            });

            divObjectServer.on('select', function () {
                ObjectServer = divObjectServer.val();
                GetObjectCatalog('cb', divObjectCatalog, ObjectType, ObjectServer, false, 0, function () { setCBValue(divObjectCatalog, ObjectCatalog); });
            });

            divObjectCatalog.on('select', function () {
                ObjectCatalog = divObjectCatalog.val();
                GetObjectSchema('cb', divObjectSchema, ObjectType, ObjectServer, ObjectCatalog, false, 0, function () { setCBValue(divObjectSchema, ObjectSchema); });
            });

            divObjectSchema.on('select', function () {
                ObjectSchema = divObjectSchema.val();
            });

            var resetWindow = function () {
                GetObjectType('cb', divObjectType, false, IsSQLObject, 0, function () { setCBValue(divObjectType, ObjectType); });

                divObjectServer.jqxComboBox({ disabled: !IsSQLObject, selectedIndex: -1 });
                divObjectCatalog.jqxComboBox({ disabled: !IsSQLObject, selectedIndex: -1 });
                divObjectSchema.jqxComboBox({ disabled: !IsSQLObject, selectedIndex: -1 });
                divObjectName.jqxInput({ value: ObjectName })

                if (!IsSQLObject) {
                    divObjectServer.val(ObjectServer);
                    divObjectCatalog.val(ObjectCatalog);
                    divObjectSchema.val(ObjectSchema);
                }

                window.jqxValidator('hide');
            }

            divIsSQLObject.bind('checked', function (event) {
                IsSQLObject = false;
                resetWindow();
            });

            divIsSQLObject.bind('unchecked', function (event) {
                IsSQLObject = true;
                resetWindow();
            });

            var validator = window.jqxValidator({
                rules: [
                       {
                           input: '#divObjectType',
                           message: 'TYPE is required!',
                           action: 'select, keyup, blur',
                           rule: function () {
                               return divObjectType.jqxComboBox('getSelectedIndex') > -1 || divObjectType.val().length > 0;
                           }
                       },
                       {
                           input: '#divObjectServer',
                           message: 'SERVER is required!',
                           action: 'select, keyup, blur',
                           rule: function () {
                               if (IsSQLObject) {
                                   return divObjectServer.jqxComboBox('getSelectedIndex') > -1 || divObjectServer.val().length > 0;
                               }
                               else {
                                   return true;
                               }
                           }
                       },
                       {
                           input: '#divObjectCatalog',
                           message: 'DATABASE is required!',
                           action: 'select, keyup, blur',
                           rule: function () {
                               if (IsSQLObject) {
                                   return divObjectCatalog.jqxComboBox('getSelectedIndex') > -1 || divObjectCatalog.val().length > 0;
                               }
                               else {
                                   return true;
                               }
                           }
                       },
                       {
                           input: '#divObjectSchema',
                           message: 'SCHEMA is required!',
                           action: 'select, keyup, blur',
                           rule: function () {
                               if (IsSQLObject) {
                                   return divObjectSchema.jqxComboBox('getSelectedIndex') > -1 || divObjectSchema.val().length > 0;
                               }
                               else {
                                   return true;
                               }
                           }
                       },
                       {
                           input: '#divObjectName',
                           message: 'NAME is required!',
                           action: 'keyup, blur',
                           rule: function () {
                               return divObjectName.val().length > 0;
                           }
                       }
                       ]
            });

            var ObjectSaved = function (SK_ObjectId) {
                _MainObjectType = divObjectType.val();
                _MainObjectServer = divObjectServer.val();
                _MainObjectCatalog = divObjectCatalog.val();
                _MainObjectSchema = divObjectSchema.val();

                GetObjectType('dd', _divMainObjectType, true, '', 0, function () { setDDValue(_divMainObjectType, _MainObjectType); });

                window.jqxWindow('close');

                if (parentWindow != null) {
                    parentWindow.jqxWindow('close');
                }

                if (SaveAndNew) {
                    showEditWindow(0, null);
                }
                else {
                    ShowDependancyWindow(SK_ObjectId, divObjectName.val(), parentWindow);
                }
            }

            validator.on('validationSuccess', function (event) {
                var UserId = '<%= Session["UserId"] %>';
                PageMethods.SaveObject(SK_ObjectId, divIsSQLObject.val(), divObjectType.val(), divObjectServer.val(), divObjectCatalog.val(), divObjectSchema.val(), divObjectName.val(), UserId, ObjectSaved, function (error) { alert(error); });
            });

            var divSave = window.find("#divSave").jqxButton({ width: '100', height: '19' });
            divSave.on('click', function () {
                window.jqxValidator('validate');
            });

            var divSaveAndNew = window.find("#divSaveAndNew").jqxButton({ width: '100', height: '19' });
            divSaveAndNew.on('click', function () {
                SaveAndNew = true;
                window.jqxValidator('validate');
            });

            var ObjectDeleted = function (SK_ObjectId) {
                if (parentWindow != null) {
                    parentWindow.jqxWindow('close');
                }
                window.jqxWindow('close');

                GetObjectType('dd', _divMainObjectType, true, '', 0, function () { setDDValue(_divMainObjectType, _MainObjectType); });
            }

            resetWindow();
        }

        function ShowDependancyWindow(SK_ObjectId, ObjectName, parentWindow) {

            var contents = '';
            contents += '<div id="divWindow">';
            contents += '   <div id="windowHeader">Dependencies</div>';
            contents += '   <div style="overflow: hidden;" id="windowContent">';
            contents += '       <b><div id="divObjectNameHeader">' + ObjectName + '</div></b>';
            contents += '       <table>';
            contents += '           <tr>';
            contents += '               <td>Dependency Type:</td>';
            contents += '               <td>';
            contents += '                   <div id="divDependencyType"></div>';
            contents += '               </td>';
            contents += '               <td>Flatten:</td>';
            contents += '               <td>';
            contents += '                   <div id="divFlattenType"></div>';
            contents += '               </td>';
            contents += '               <td>Max Depth:</td>';
            contents += '               <td>';
            contents += '                   <div id="divMaxDepth"></div>';
            contents += '               </td>';
            contents += '               <td>';
            contents += '                   <div id="divEditObject">Edit</div>';
            contents += '               </td>';
            contents += '               <td>';
            contents += '                   <div id="divNewDependancy">New</div>';
            contents += '               </td>';
            contents += '               <td>';
            contents += '                   <div id="divExport">Export</div>';
            contents += '               </td>';
            contents += '               <td>';
            contents += '                   <div id="divEditDependancy">Edit</div>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '       </table>';
            contents += '       <div id="divDependencyTableOuter"></div>';
            contents += '   <div>';
            contents += '<div>';

            var window = $(contents).jqxWindow({
                showCollapseButton: true,
                maxHeight: 600,
                maxWidth: 1020,
                minHeight: 200,
                minWidth: 200,
                height: 600,
                width: 1020,
                isModal: true,
                showCollapseButton: false,
                resizable: false,
                draggable: false
            });

            var divEditObject = window.find('#divEditObject');
            divEditObject.hide();

            var divObjectNameHeader = window.find('#divObjectNameHeader');

            var divNewDependancy = window.find('#divNewDependancy');
            divNewDependancy.jqxButton({ width: '100', height: '19' });

            var divExport = window.find('#divExport');
            divExport.jqxButton({ width: '100', height: '19' });

            var divEditDependancy = window.find('#divEditDependancy');
            divEditDependancy.jqxButton({ width: '100', height: '19' });
            divEditDependancy.hide();

            if (SK_ObjectId != 0) {
                var da = getRecordData(SK_ObjectId, function () {
                    if (da.records.length == 1) {
                        var rec = da.records[0];
                        if (rec.ObjectId == "") {
                            divEditObject.show();
                            divEditObject.jqxButton({ width: '100', height: '19' });
                            divEditObject.on('click', function () {
                                showEditWindow(SK_ObjectId, window);
                            });
                        }
                        divObjectNameHeader.text(rec.ObjectName + ' (' + rec.ObjectType + ')');
                    }
                });
                da.dataBind();
            }
            else {
                divObjectNameHeader.text(ObjectName);
            }

            window.on('close', function (event) {
                window.jqxWindow('destroy');
            });

            var maxDepthSource = ["1", "2", "3", "4", "5", "6", "7", "None"];

            var divDependencyType = window.find('#divDependencyType').jqxSwitchButton({ width: 175, height: 25, onLabel: 'Dependent On', offLabel: 'Depends On this', thumbSize: '15px', checked: true });
            var divFlattenType = window.find('#divFlattenType').jqxSwitchButton({ width: 75, height: 25, onLabel: 'No', offLabel: 'Yes', thumbSize: '15px', checked: true });
            var divMaxDepth = window.find('#divMaxDepth').jqxDropDownList({ source: maxDepthSource, width: '65', height: '25', selectedIndex: 1 });

            var Direction = 'DOWN';
            var Flatten = false;
            var MaxDepth = divMaxDepth.val();

            var loadDependenciesTable = function () {
                var divDependencyTableOuter = window.find('#divDependencyTableOuter');
                divDependencyTableOuter.empty();
                var divDependencyTable = $('<div id="divDependencyTable"></div>');

                var source =
                {
                    datatype: 'xml',
                    datafields: [
                        { name: 'SK_DependencyId', map: 'SK_DependencyId', type: 'number' },
                        { name: 'Parent_SK_DependencyId', map: 'Parent_SK_DependencyId', type: 'number' },
                        { name: 'SK_ObjectId', map: 'SK_ObjectId', type: 'number' },
                        { name: 'ObjectType', map: 'ObjectType', type: 'string' },
                        { name: 'ObjectServer', map: 'ObjectServer', type: 'string' },
                        { name: 'ObjectCatalog', map: 'ObjectCatalog', type: 'string' },
                        { name: 'ObjectSchema', map: 'ObjectSchema', type: 'string' },
                        { name: 'ObjectName', map: 'ObjectName', type: 'string' },
                        { name: 'FullName', map: 'FullName', type: 'string' },
                        { name: 'Depth', map: 'Depth', type: 'number' },
                        { name: 'Ref_SK_ObjectId', map: 'Ref_SK_ObjectId', type: 'number' },
                        { name: 'IsAuto', map: 'IsAuto', type: 'boolean' },
                        { name: 'Trigger_SK_ObjectId', map: 'Trigger_SK_ObjectId', type: 'number' },
                        { name: 'TriggerObjectType', map: 'TriggerObjectType', type: 'string' },
                        { name: 'TriggerObjectServer', map: 'TriggerObjectServer', type: 'string' },
                        { name: 'TriggerObjectCatalog', map: 'TriggerObjectCatalog', type: 'string' },
                        { name: 'TriggerObjectSchema', map: 'TriggerObjectSchema', type: 'string' },
                        { name: 'TriggerObjectName', map: 'TriggerObjectName', type: 'string' },
                        { name: 'TriggerFullName', map: 'TriggerFullName', type: 'string' }
                    ],
                    root: 'NewDataSet',
                    record: 'Record',
                    url: 'Dependencies.aspx/GetDependencies',
                    //                    id: 'SK_DependencyId',
                    hierarchy:
                    {
                        keyDataField: { name: 'SK_DependencyId' },
                        parentDataField: { name: 'Parent_SK_DependencyId' }
                    },
                    data: {
                        SK_ObjectId: '"' + SK_ObjectId + '"',
                        Direction: '"' + Direction + '"',
                        Flatten: '"' + Flatten + '"',
                        MaxDepth: '"' + MaxDepth + '"'
                    }
                };

                dataAdapter = new $.jqx.dataAdapter(source, { contentType: 'application/json; charset=utf-8', loadComplete: function () { } });

                var maxheight = 510;

                var cellsRenderer = function (row, column, value, rowData) {
                    var contents = '<div>';
                    contents += '<table style="width: 100%; height: 20px;">';
                    contents += '   <tr>';

                    if (rowData.SK_ObjectId != SK_ObjectId && rowData.IsAuto == false && rowData.Depth == 1) {
                        contents += '       <td align="center" valign="middle">';
                        contents += '           <img src="Images/Delete.png" alt="Delete" style="width:15px;height:15px; cursor: pointer;" />';
                        contents += '       </td>';
                    }
                    else {
                        contents += '       <td></td>';
                    }

                    contents += '   </tr>';
                    contents += '</table></div>';
                    return contents;
                }

                divDependencyTable.jqxTreeGrid(
                {
                    width: 1000,
                    source: dataAdapter,
                    pageable: false,
                    columnsResize: false,
                    sortable: true,
                    scrollbarsize: 10,
                    height: maxheight,
                    ready: function () {
                        var recordsHeight = dataAdapter.records.length * 20 + 30;

                        if (recordsHeight > maxheight) {
                            divDependencyTable.jqxTreeGrid({ width: 1000 });
                        }
                        else {
                            divDependencyTable.jqxTreeGrid({ width: 985 });
                        }

                        divDependencyTable.jqxTreeGrid('expandRow', 0);

                        divEditDependancy.off('click');
                        divEditDependancy.hide();
                    },
                    columns: [
                      { text: 'Full Name', dataField: 'FullName', width: 695 },
                      { text: 'Trigger', dataField: 'TriggerObjectName', width: 200 },
                      { text: 'Depth', dataField: 'Depth', width: 50, cellsAlign: 'right' },
                      { text: ' ', dataField: 'IsAuto', width: 40, cellsRenderer: cellsRenderer }
                    ]
                });

                divDependencyTable.on('rowClick',
                    function (event) {
                        if (event.args.dataField == 'IsAuto') {
                            if (event.args.row.SK_ObjectId != SK_ObjectId && event.args.row.IsAuto == false && event.args.row.Depth == 1) {
                                var DependancyDeleted = function () {
                                    loadDependenciesTable();
                                }

                                if (confirm('Are you sure?')) {
                                    PageMethods.DeleteDependancy(event.args.row.SK_DependencyId, DependancyDeleted, function (error) { alert(error); });
                                }
                            }
                        }
                    });

                divDependencyTable.on('rowDoubleClick', function (event) {
                    if (args.row.SK_ObjectId != SK_ObjectId) {
                        ShowDependancyWindow(args.row.SK_ObjectId, args.row.FullName, window);
                    }
                });

                divDependencyTable.on('rowSelect', function (event) {
                    if (event.args.row.SK_ObjectId != SK_ObjectId && event.args.row.IsAuto == false && event.args.row.Depth == 1) {
                        divEditDependancy.show();
                        divEditDependancy.on('click', function () {
                            showEditDependancyWindow(args.row.SK_DependencyId, SK_ObjectId, Direction, window, dataAdapter, loadDependenciesTable);
                        });
                    }
                });

                divDependencyTable.on('rowUnselect', function (event) {
                    divEditDependancy.off('click');
                    divEditDependancy.hide();
                });

                divExport.on('click', function () {
                    divDependencyTable.jqxTreeGrid('exportData', 'xls');
                });

                divDependencyTableOuter.append(divDependencyTable);
            }

            divDependencyType.bind('checked', function (event) {
                Direction = 'UP';
                loadDependenciesTable();
            });

            divDependencyType.bind('unchecked', function (event) {
                Direction = 'DOWN';
                loadDependenciesTable();
            });

            divFlattenType.bind('checked', function (event) {
                Flatten = true;
                loadDependenciesTable();
            });

            divFlattenType.bind('unchecked', function (event) {
                Flatten = false;
                loadDependenciesTable();
            });

            divMaxDepth.on('select', function () {
                MaxDepth = divMaxDepth.val();
                loadDependenciesTable();
            });

            divNewDependancy.on('click', function () {
                showEditDependancyWindow(0, SK_ObjectId, Direction, window, null, loadDependenciesTable);
            });

            loadDependenciesTable();
            $('body').append(window);
        }

        function getRecordData(SK_ObjectId, loadComplete) {
            var source =
                {
                    datatype: 'xml',
                    datafields: [
                        { name: 'SK_ObjectId', map: 'SK_ObjectId', type: 'number' },
                        { name: 'IsSQLObject', map: 'IsSQLObject', type: 'boolean' },
                        { name: 'ObjectType', map: 'ObjectType', type: 'string' },
                        { name: 'FullName', map: 'FullName', type: 'string' },
                        { name: 'ObjectId', map: 'ObjectId', type: 'number' },
                        { name: 'ObjectServer', map: 'ObjectServer', type: 'string' },
                        { name: 'ObjectCatalog', map: 'ObjectCatalog', type: 'string' },
                        { name: 'ObjectSchema', map: 'ObjectSchema', type: 'string' },
                        { name: 'ObjectName', map: 'ObjectName', type: 'string' }
                    ],
                    root: 'NewDataSet',
                    record: 'Record',
                    url: 'Dependencies.aspx/GetRecordData',
                    id: 'SK_ObjectId',
                    data: {
                        SK_ObjectId: '"' + SK_ObjectId + '"'
                    }
                };

            return new $.jqx.dataAdapter(source, { contentType: 'application/json; charset=utf-8', loadComplete: loadComplete, loadError: function (e) { alert(e); } });
        }

        function showEditDependancyWindow(SK_DependencyId, SK_ObjectId, parentDirection, parentWindow, parentDataAdapter, parentloadDependenciesTable) {

            var Direction = parentDirection;
            var ObjectType = _LastObjectType;
            var ObjectServer = _LastObjectServer;
            var ObjectCatalog = _LastObjectCatalog;
            var ObjectSchema = _LastObjectSchema;
            var ObjectName = "";

            var HasTrigger = _HasTrigger;
            var TriggerObjectType = _TriggerObjectType;
            var TriggerObjectServer = _TriggerObjectServer;
            var TriggerObjectCatalog = _TriggerObjectCatalog;
            var TriggerObjectSchema = _TriggerObjectSchema;
            var TriggerObjectName = _TriggerObjectName;

            if (SK_DependencyId > 0) {
                for (var r = 0; r < parentDataAdapter.records.length; r++) {
                    var rec = parentDataAdapter.records[r];
                    if (rec.SK_DependencyId == SK_DependencyId) {
                        ObjectType = rec.ObjectType;
                        ObjectServer = rec.ObjectServer;
                        ObjectCatalog = rec.ObjectCatalog;
                        ObjectSchema = rec.ObjectSchema;
                        ObjectName = rec.ObjectName;

                        HasTrigger = rec.Trigger_SK_ObjectId > 0;
                        Trigger_SK_ObjectId = rec.Trigger_SK_ObjectId;
                        TriggerObjectType = rec.TriggerObjectType;
                        TriggerObjectServer = rec.TriggerObjectServer;
                        TriggerObjectCatalog = rec.TriggerObjectCatalog;
                        TriggerObjectSchema = rec.TriggerObjectSchema;
                        TriggerObjectName = rec.TriggerObjectName;
                    }
                }
            }

            var contents = '';
            contents += '<div id="divWindow">';
            contents += '   <div id="windowHeader">Dependencies</div>';
            contents += '   <div style="overflow: hidden;" id="windowContent">';
            contents += '       <table>';
            contents += '           <tr>';
            contents += '               <td valign="top">';
            contents += '                   <table>';
            contents += '                       <tr>';
            contents += '                           <td>Dependency Type:</td>';
            contents += '                           <td>';
            contents += '                               <div id="divDependencyType"></div>';
            contents += '                           </td>';
            contents += '                       </tr>';
            contents += '                       <tr>';
            contents += '                           <td>TYPE:</td>';
            contents += '                           <td>';
            contents += '                               <div id="divObjectType"></div>';
            contents += '                           </td>';
            contents += '                       </tr>';
            contents += '                       <tr>';
            contents += '                           <td>SERVER:</td>';
            contents += '                           <td>';
            contents += '                               <div id="divObjectServer"></div>';
            contents += '                           </td>';
            contents += '                       </tr>';
            contents += '                       <tr>';
            contents += '                           <td>DATABASE:</td>';
            contents += '                           <td>';
            contents += '                               <div id="divObjectCatalog"></div>';
            contents += '                           </td>';
            contents += '                       </tr>';
            contents += '                       <tr>';
            contents += '                           <td>SCHEMA:</td>';
            contents += '                           <td>';
            contents += '                               <div id="divObjectSchema"></div>';
            contents += '                           </td>';
            contents += '                       </tr>';
            contents += '                       <tr>';
            contents += '                           <td>NAME:</td>';
            contents += '                           <td>';
            contents += '                               <div id="divObjectName"></div>';
            contents += '                           </td>';
            contents += '                       </tr>';
            contents += '                   </table>';
            contents += '               </td>';
            contents += '               <td>';
            contents += '                   <table>';
            contents += '                       <tr>';
            contents += '                           <td>Has Trigger:</td>';
            contents += '                           <td>';
            contents += '                               <div id="divTrigger"></div>';
            contents += '                           </td>';
            contents += '                       </tr>';
            contents += '                       <tr>';
            contents += '                           <td>TYPE:</td>';
            contents += '                           <td>';
            contents += '                               <div id="divTriggerObjectType"></div>';
            contents += '                           </td>';
            contents += '                       </tr>';
            contents += '                       <tr>';
            contents += '                           <td>SERVER:</td>';
            contents += '                           <td>';
            contents += '                               <div id="divTriggerObjectServer"></div>';
            contents += '                           </td>';
            contents += '                       </tr>';
            contents += '                       <tr>';
            contents += '                           <td>DATABASE:</td>';
            contents += '                           <td>';
            contents += '                               <div id="divTriggerObjectCatalog"></div>';
            contents += '                           </td>';
            contents += '                       </tr>';
            contents += '                       <tr>';
            contents += '                           <td>SCHEMA:</td>';
            contents += '                           <td>';
            contents += '                               <div id="divTriggerObjectSchema"></div>';
            contents += '                           </td>';
            contents += '                       </tr>';
            contents += '                       <tr>';
            contents += '                           <td>NAME:</td>';
            contents += '                           <td>';
            contents += '                               <div id="divTriggerObjectName"></div>';
            contents += '                           </td>';
            contents += '                       </tr>';
            contents += '                   </table>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '       </table>';
            contents += '       <table>';
            contents += '           <tr>';
            contents += '               <td>';
            contents += '                   <div id="divSave">Save</div>';
            contents += '               </td>';
            contents += '               <td>';
            contents += '                   <div id="divSaveAndNew">Save & New</div>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '       </table>';
            contents += '   <div>';
            contents += '<div>';

            var window = $(contents).jqxWindow({
                showCollapseButton: true,
                maxHeight: 275,
                maxWidth: 1000,
                minHeight: 275,
                minWidth: 1000,
                height: 275,
                width: 1000,
                isModal: true,
                showCollapseButton: false,
                resizable: false,
                draggable: false
            });

            var SaveAndNew = false;

            window.on('close', function (event) {
                window.jqxValidator('hide');
                window.jqxWindow('destroy');
                parentloadDependenciesTable();

                if (SaveAndNew) {
                    showEditDependancyWindow(SK_DependencyId, SK_ObjectId, parentDirection, parentWindow, parentDataAdapter, parentloadDependenciesTable);
                }
            });

            var divDependencyType = window.find('#divDependencyType').jqxSwitchButton({ width: '175', height: '25', onLabel: 'Dependent On', offLabel: 'Depends On this', thumbSize: '15px', checked: Direction != 'UP' });
            var divObjectType = window.find('#divObjectType').jqxDropDownList({ width: '350', dropDownWidth: '500', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData' });
            var divObjectServer = window.find('#divObjectServer').jqxDropDownList({ width: '350', dropDownWidth: '500', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData' });
            var divObjectCatalog = window.find('#divObjectCatalog').jqxDropDownList({ width: '350', dropDownWidth: '500', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData' });
            var divObjectSchema = window.find('#divObjectSchema').jqxDropDownList({ width: '350', dropDownWidth: '500', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData' });
            var divObjectName = window.find('#divObjectName').jqxDropDownList({ width: '350', dropDownWidth: '500', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData' });

            var divTrigger = window.find('#divTrigger').jqxSwitchButton({ width: '65', height: '25', onLabel: 'Yes', offLabel: 'No', thumbSize: '15px', checked: HasTrigger });
            var divTriggerObjectType = window.find('#divTriggerObjectType').jqxDropDownList({ width: '350', dropDownWidth: '500', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData', disabled: !HasTrigger });
            var divTriggerObjectServer = window.find('#divTriggerObjectServer').jqxDropDownList({ width: '350', dropDownWidth: '500', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData', disabled: !HasTrigger });
            var divTriggerObjectCatalog = window.find('#divTriggerObjectCatalog').jqxDropDownList({ width: '350', dropDownWidth: '500', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData', disabled: !HasTrigger });
            var divTriggerObjectSchema = window.find('#divTriggerObjectSchema').jqxDropDownList({ width: '350', dropDownWidth: '500', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData', disabled: !HasTrigger });
            var divTriggerObjectName = window.find('#divTriggerObjectName').jqxDropDownList({ width: '350', dropDownWidth: '500', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData', disabled: !HasTrigger });

            divObjectType.on('select', function () {
                ObjectType = divObjectType.val();
                GetObjectServer('dd', divObjectServer, ObjectType, false, SK_ObjectId, function () { setDDValue(divObjectServer, ObjectServer); });
            });

            divTriggerObjectType.on('select', function () {
                TriggerObjectType = divTriggerObjectType.val();
                GetObjectServer('dd', divTriggerObjectServer, TriggerObjectType, false, SK_ObjectId, function () { setDDValue(divTriggerObjectServer, TriggerObjectServer); });
            });

            divObjectServer.on('select', function () {
                ObjectServer = divObjectServer.val();
                GetObjectCatalog('dd', divObjectCatalog, ObjectType, ObjectServer, false, SK_ObjectId, function () { setDDValue(divObjectCatalog, ObjectCatalog); });
            });

            divTriggerObjectServer.on('select', function () {
                TriggerObjectServer = divTriggerObjectServer.val();
                GetObjectCatalog('dd', divTriggerObjectCatalog, TriggerObjectType, TriggerObjectServer, false, SK_ObjectId, function () { setDDValue(divTriggerObjectCatalog, TriggerObjectCatalog); });
            });

            divObjectCatalog.on('select', function () {
                ObjectCatalog = divObjectCatalog.val();
                GetObjectSchema('dd', divObjectSchema, ObjectType, ObjectServer, ObjectCatalog, false, SK_ObjectId, function () { setDDValue(divObjectSchema, ObjectSchema); });
            });

            divTriggerObjectCatalog.on('select', function () {
                TriggerObjectCatalog = divTriggerObjectCatalog.val();
                GetObjectSchema('dd', divTriggerObjectSchema, TriggerObjectType, TriggerObjectServer, TriggerObjectCatalog, false, SK_ObjectId, function () { setDDValue(divTriggerObjectSchema, TriggerObjectSchema); });
            });

            divObjectSchema.on('select', function () {
                ObjectSchema = divObjectSchema.val();
                GetObjectName('dd', divObjectName, ObjectType, ObjectServer, ObjectCatalog, ObjectSchema, false, SK_ObjectId, function () { setDDValue(divObjectName, ObjectName); });
            });

            divTriggerObjectSchema.on('select', function () {
                TriggerObjectSchema = divTriggerObjectSchema.val();
                GetObjectName('dd', divTriggerObjectName, TriggerObjectType, TriggerObjectServer, TriggerObjectCatalog, TriggerObjectSchema, false, SK_ObjectId, function () { setDDValue(divTriggerObjectName, TriggerObjectName); });
            });

            divObjectName.on('select', function () {
                ObjectName = divObjectName.val();
            });

            divTriggerObjectName.on('select', function () {
                TriggerObjectName = divTriggerObjectName.val();
            });

            divDependencyType.bind('checked', function (event) {
                Direction = 'UP';
            });

            divDependencyType.bind('unchecked', function (event) {
                Direction = 'DOWN';
            });

            divTrigger.bind('checked', function (event) {
                HasTrigger = false;
                divTriggerObjectType.jqxDropDownList({ disabled: true, selectedIndex: -1 });
                divTriggerObjectServer.jqxDropDownList({ disabled: true, selectedIndex: -1 });
                divTriggerObjectCatalog.jqxDropDownList({ disabled: true, selectedIndex: -1 });
                divTriggerObjectSchema.jqxDropDownList({ disabled: true, selectedIndex: -1 });
                divTriggerObjectName.jqxDropDownList({ disabled: true, selectedIndex: -1 });
                window.jqxValidator('hideHint', '#divTriggerObjectType');
                window.jqxValidator('hideHint', '#divTriggerObjectServer');
                window.jqxValidator('hideHint', '#divTriggerObjectCatalog');
                window.jqxValidator('hideHint', '#divTriggerObjectSchema');
                window.jqxValidator('hideHint', '#divTriggerObjectName');
            });

            divTrigger.bind('unchecked', function (event) {
                HasTrigger = true;
                divTriggerObjectType.jqxDropDownList({ disabled: false });
                divTriggerObjectServer.jqxDropDownList({ disabled: false });
                divTriggerObjectCatalog.jqxDropDownList({ disabled: false });
                divTriggerObjectSchema.jqxDropDownList({ disabled: false });
                divTriggerObjectName.jqxDropDownList({ disabled: false });
                GetObjectType('dd', divTriggerObjectType, false, '', SK_ObjectId, function () { setDDValue(divTriggerObjectType, TriggerObjectType); });
            });

            var validator = window.jqxValidator({
                rules: [
                       {
                           input: '#divObjectType',
                           message: 'TYPE is required!',
                           action: 'select',
                           rule: function () {
                               return divObjectType.jqxDropDownList('getSelectedIndex') > -1 || divObjectType.val().length > 0;
                           }
                       },
                       {
                           input: '#divObjectServer',
                           message: 'SERVER is required!',
                           action: 'select',
                           rule: function () {
                               return divObjectServer.jqxDropDownList('getSelectedIndex') > -1 || divObjectServer.val().length > 0;
                           }
                       },
                       {
                           input: '#divObjectCatalog',
                           message: 'DATABASE is required!',
                           action: 'select',
                           rule: function () {
                               return divObjectCatalog.jqxDropDownList('getSelectedIndex') > -1 || divObjectCatalog.val().length > 0;
                           }
                       },
                       {
                           input: '#divObjectSchema',
                           message: 'SCHEMA is required!',
                           action: 'select',
                           rule: function () {
                               return divObjectSchema.jqxDropDownList('getSelectedIndex') > -1 || divObjectSchema.val().length > 0;
                           }
                       },
                       {
                           input: '#divObjectName',
                           message: 'NAME is required!',
                           action: 'select',
                           rule: function () {
                               return divObjectName.jqxDropDownList('getSelectedIndex') > -1 || divObjectName.val().length > 0;
                           }
                       },
                       {
                           input: '#divTriggerObjectType',
                           message: 'TYPE is required!',
                           action: 'select',
                           rule: function () {
                               if (divTrigger.jqxSwitchButton('checked')) {
                                   return divTriggerObjectType.jqxDropDownList('getSelectedIndex') > -1 || divTriggerObjectType.val().length > 0;
                               }
                               else {
                                   return true;
                               }
                           }
                       },
                       {
                           input: '#divTriggerObjectServer',
                           message: 'SERVER is required!',
                           action: 'select',
                           rule: function () {
                               if (divTrigger.jqxSwitchButton('checked')) {
                                   return divTriggerObjectServer.jqxDropDownList('getSelectedIndex') > -1 || divTriggerObjectServer.val().length > 0;
                               }
                               else {
                                   return true;
                               }
                           }
                       },
                       {
                           input: '#divTriggerObjectCatalog',
                           message: 'DATABASE is required!',
                           action: 'select',
                           rule: function () {
                               if (divTrigger.jqxSwitchButton('checked')) {
                                   return divTriggerObjectCatalog.jqxDropDownList('getSelectedIndex') > -1 || divTriggerObjectCatalog.val().length > 0;
                               }
                               else {
                                   return true;
                               }
                           }
                       },
                       {
                           input: '#divTriggerObjectSchema',
                           message: 'SCHEMA is required!',
                           action: 'select',
                           rule: function () {
                               if (divTrigger.jqxSwitchButton('checked')) {
                                   return divTriggerObjectSchema.jqxDropDownList('getSelectedIndex') > -1 || divTriggerObjectSchema.val().length > 0;
                               }
                               else {
                                   return true;
                               }
                           }
                       },
                       {
                           input: '#divTriggerObjectName',
                           message: 'NAME is required!',
                           action: 'select',
                           rule: function () {
                               if (divTrigger.jqxSwitchButton('checked')) {
                                   return divTriggerObjectName.jqxDropDownList('getSelectedIndex') > -1 || divTriggerObjectName.val().length > 0;
                               }
                               else {
                                   return true;
                               }
                           }
                       }
                       ]
            });

            var DependancySaved = function () {
                _LastObjectType = divObjectType.val()
                _LastObjectServer = divObjectServer.val()
                _LastObjectCatalog = divObjectCatalog.val()
                _LastObjectSchema = divObjectSchema.val()
                window.jqxWindow('close');
            }

            validator.on('validationSuccess', function (event) {
                var UserId = '<%= Session["UserId"] %>';
                var dSK_ObjectId;
                var dref_SK_ObjectId;

                if (divDependencyType.val() == true) {
                    dSK_ObjectId = SK_ObjectId;
                    dref_SK_ObjectId = divObjectName.val();
                }
                else {
                    dSK_ObjectId = divObjectName.val();
                    dref_SK_ObjectId = SK_ObjectId;
                }

                PageMethods.SaveDependancy(SK_DependencyId, Direction, SK_ObjectId, divObjectType.val(), divObjectServer.val(), divObjectCatalog.val(), divObjectSchema.val(), divObjectName.val(), HasTrigger, divTriggerObjectType.val(), divTriggerObjectServer.val(), divTriggerObjectCatalog.val(), divTriggerObjectSchema.val(), divTriggerObjectName.val(), UserId, DependancySaved, function (error) { alert(error); });
            });

            var divSave = window.find("#divSave").jqxButton({ width: '100', height: '19' });
            divSave.on('click', function () {
                window.jqxValidator('validate');
            });

            var divSaveAndNew = window.find("#divSaveAndNew").jqxButton({ width: '100', height: '19' });
            divSaveAndNew.on('click', function () {
                SaveAndNew = true;
                window.jqxValidator('validate');
            });

            GetObjectType('dd', divObjectType, false, '', SK_ObjectId, function () { setDDValue(divObjectType, ObjectType); });

            if (TriggerObjectName.length > 0) {
                GetObjectType('dd', divTriggerObjectType, false, '', SK_ObjectId, function () { setDDValue(divTriggerObjectType, TriggerObjectType); });
            }
        }

        function showDefaults() {

            var HasTrigger = _HasTrigger;
            var TriggerObjectType = _TriggerObjectType
            var TriggerObjectServer = _TriggerObjectServer
            var TriggerObjectCatalog = _TriggerObjectCatalog
            var TriggerObjectSchema = _TriggerObjectSchema
            var TriggerObjectName = _TriggerObjectName

            var contents = '';
            contents += '<div id="divWindow">';
            contents += '   <div id="windowHeader">Defaults</div>';
            contents += '   <div style="overflow: hidden;" id="windowContent">';
            contents += '       <table>';
            contents += '           <tr>';
            contents += '               <td>Has Trigger:</td>';
            contents += '               <td>';
            contents += '                   <div id="divDefaultTrigger"></div>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '           <tr>';
            contents += '               <td>TYPE:</td>';
            contents += '               <td>';
            contents += '                   <div id="divDefaultTriggerObjectType"></div>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '           <tr>';
            contents += '               <td>SERVER:</td>';
            contents += '               <td>';
            contents += '                   <div id="divDefaultTriggerObjectServer"></div>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '           <tr>';
            contents += '               <td>DATABASE:</td>';
            contents += '               <td>';
            contents += '                   <div id="divDefaultTriggerObjectCatalog"></div>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '           <tr>';
            contents += '               <td>SCHEMA:</td>';
            contents += '               <td>';
            contents += '                   <div id="divDefaultTriggerObjectSchema"></div>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '           <tr>';
            contents += '               <td>NAME:</td>';
            contents += '               <td>';
            contents += '                   <div id="divDefaultTriggerObjectName"></div>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '        </table>';
            contents += '       <table>';
            contents += '           <tr>';
            contents += '               <td>';
            contents += '                   <div id="divSave">Save</div>';
            contents += '               </td>';
            contents += '           </tr>';
            contents += '       </table>';
            contents += '   <div>';
            contents += '<div>';

            var window = $(contents).jqxWindow({
                showCollapseButton: true,
                maxHeight: 275,
                maxWidth: 500,
                minHeight: 275,
                minWidth: 500,
                height: 275,
                width: 500,
                isModal: true,
                showCollapseButton: false,
                resizable: false,
                draggable: false
            });

            window.on('close', function (event) {
                window.jqxValidator('hide');
                window.jqxWindow('destroy');
            });

            var divDefaultTrigger = window.find('#divDefaultTrigger').jqxSwitchButton({ width: '65', height: '25', onLabel: 'Yes', offLabel: 'No', thumbSize: '15px', checked: HasTrigger });
            var divDefaultTriggerObjectType = window.find('#divDefaultTriggerObjectType').jqxDropDownList({ width: '350', dropDownWidth: '500', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData', disabled: !HasTrigger });
            var divDefaultTriggerObjectServer = window.find('#divDefaultTriggerObjectServer').jqxDropDownList({ width: '350', dropDownWidth: '500', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData', disabled: !HasTrigger });
            var divDefaultTriggerObjectCatalog = window.find('#divDefaultTriggerObjectCatalog').jqxDropDownList({ width: '350', dropDownWidth: '500', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData', disabled: !HasTrigger });
            var divDefaultTriggerObjectSchema = window.find('#divDefaultTriggerObjectSchema').jqxDropDownList({ width: '350', dropDownWidth: '500', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData', disabled: !HasTrigger });
            var divDefaultTriggerObjectName = window.find('#divDefaultTriggerObjectName').jqxDropDownList({ width: '350', dropDownWidth: '500', height: '25', displayMember: 'ObjectData', valueMember: 'ObjectData', disabled: !HasTrigger });

            divDefaultTriggerObjectType.on('select', function () {
                TriggerObjectType = divDefaultTriggerObjectType.val();
                GetObjectServer('dd', divDefaultTriggerObjectServer, TriggerObjectType, false, 0, function () { setDDValue(divDefaultTriggerObjectServer, TriggerObjectServer); });
            });

            divDefaultTriggerObjectServer.on('select', function () {
                TriggerObjectServer = divDefaultTriggerObjectServer.val();
                GetObjectCatalog('dd', divDefaultTriggerObjectCatalog, TriggerObjectType, TriggerObjectServer, false, 0, function () { setDDValue(divDefaultTriggerObjectCatalog, TriggerObjectCatalog); });
            });

            divDefaultTriggerObjectCatalog.on('select', function () {
                TriggerObjectCatalog = divDefaultTriggerObjectCatalog.val();
                GetObjectSchema('dd', divDefaultTriggerObjectSchema, TriggerObjectType, TriggerObjectServer, TriggerObjectCatalog, false, 0, function () { setDDValue(divDefaultTriggerObjectSchema, TriggerObjectSchema); });
            });

            divDefaultTriggerObjectSchema.on('select', function () {
                TriggerObjectSchema = divDefaultTriggerObjectSchema.val();
                GetObjectName('dd', divDefaultTriggerObjectName, TriggerObjectType, TriggerObjectServer, TriggerObjectCatalog, TriggerObjectSchema, false, 0, function () { setDDValue(divDefaultTriggerObjectName, TriggerObjectName); });
            });

            divDefaultTriggerObjectName.on('select', function () {
                TriggerObjectName = divDefaultTriggerObjectName.val();
            });

            divDefaultTrigger.bind('checked', function (event) {
                HasTrigger = false;
                divDefaultTriggerObjectType.jqxDropDownList({ disabled: true, selectedIndex: -1 });
                divDefaultTriggerObjectServer.jqxDropDownList({ disabled: true, selectedIndex: -1 });
                divDefaultTriggerObjectCatalog.jqxDropDownList({ disabled: true, selectedIndex: -1 });
                divDefaultTriggerObjectSchema.jqxDropDownList({ disabled: true, selectedIndex: -1 });
                divDefaultTriggerObjectName.jqxDropDownList({ disabled: true, selectedIndex: -1 });
                window.jqxValidator('hideHint', '#divDefaultTriggerObjectType');
                window.jqxValidator('hideHint', '#divDefaultTriggerObjectServer');
                window.jqxValidator('hideHint', '#divDefaultTriggerObjectCatalog');
                window.jqxValidator('hideHint', '#divDefaultTriggerObjectSchema');
                window.jqxValidator('hideHint', '#divDefaultTriggerObjectName');
            });

            divDefaultTrigger.bind('unchecked', function (event) {
                HasTrigger = true;
                divDefaultTriggerObjectType.jqxDropDownList({ disabled: false });
                divDefaultTriggerObjectServer.jqxDropDownList({ disabled: false });
                divDefaultTriggerObjectCatalog.jqxDropDownList({ disabled: false });
                divDefaultTriggerObjectSchema.jqxDropDownList({ disabled: false });
                divDefaultTriggerObjectName.jqxDropDownList({ disabled: false });
                GetObjectType('dd', divDefaultTriggerObjectType, false, '', 0, function () { setDDValue(divDefaultTriggerObjectType, TriggerObjectType); });
            });

            var validator = window.jqxValidator({
                rules: [
                       {
                           input: '#divDefaultTriggerObjectType',
                           message: 'TYPE is required!',
                           action: 'select',
                           rule: function () {
                               if (HasTrigger) {
                                   return divDefaultTriggerObjectType.jqxDropDownList('getSelectedIndex') > -1 || divDefaultTriggerObjectType.val().length > 0;
                               }
                               else {
                                   return true;
                               }
                           }
                       },
                       {
                           input: '#divDefaultTriggerObjectServer',
                           message: 'SERVER is required!',
                           action: 'select',
                           rule: function () {
                               if (HasTrigger) {
                                   return divDefaultTriggerObjectServer.jqxDropDownList('getSelectedIndex') > -1 || divDefaultTriggerObjectServer.val().length > 0;
                               }
                               else {
                                   return true;
                               }
                           }
                       },
                       {
                           input: '#divDefaultTriggerObjectCatalog',
                           message: 'DATABASE is required!',
                           action: 'select',
                           rule: function () {
                               if (HasTrigger) {
                                   return divDefaultTriggerObjectCatalog.jqxDropDownList('getSelectedIndex') > -1 || divDefaultTriggerObjectCatalog.val().length > 0;
                               }
                               else {
                                   return true;
                               }
                           }
                       },
                       {
                           input: '#divDefaultTriggerObjectSchema',
                           message: 'SCHEMA is required!',
                           action: 'select',
                           rule: function () {
                               if (HasTrigger) {
                                   return divDefaultTriggerObjectSchema.jqxDropDownList('getSelectedIndex') > -1 || divDefaultTriggerObjectSchema.val().length > 0;
                               }
                               else {
                                   return true;
                               }
                           }
                       },
                       {
                           input: '#divDefaultTriggerObjectName',
                           message: 'NAME is required!',
                           action: 'select',
                           rule: function () {
                               if (HasTrigger) {
                                   return divDefaultTriggerObjectName.jqxDropDownList('getSelectedIndex') > -1 || divDefaultTriggerObjectName.val().length > 0;
                               }
                               else {
                                   return true;
                               }
                           }
                       }
                       ]
            });

            validator.on('validationSuccess', function (event) {
                if (HasTrigger) {
                    _HasTrigger = HasTrigger
                    _TriggerObjectType = TriggerObjectType;
                    _TriggerObjectServer = TriggerObjectServer;
                    _TriggerObjectCatalog = TriggerObjectCatalog;
                    _TriggerObjectSchema = TriggerObjectSchema;
                    _TriggerObjectName = TriggerObjectName;
                }
                else {
                    _HasTrigger = HasTrigger
                    _TriggerObjectType = "";
                    _TriggerObjectServer = "";
                    _TriggerObjectCatalog = "";
                    _TriggerObjectSchema = "";
                    _TriggerObjectName = "";
                }
                window.jqxWindow('close');
            });

            var divSave = window.find("#divSave").jqxButton({ width: '100', height: '19' });
            divSave.on('click', function () {
                window.jqxValidator('validate');
            });

            GetObjectType('dd', divDefaultTriggerObjectType, false, '', 0, function () { setDDValue(divDefaultTriggerObjectType, TriggerObjectType); });
        }
    </script>
    <table>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            TYPE
                        </td>
                        <td>
                            SERVER
                        </td>
                        <td>
                            DATABASE
                        </td>
                        <td>
                            SCHEMA
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="divMainObjectType">
                                TYPE</div>
                        </td>
                        <td>
                            <div id="divMainObjectServer">
                                SERVER</div>
                        </td>
                        <td>
                            <div id="divMainObjectCatalog">
                                DATABASE</div>
                        </td>
                        <td>
                            <div id="divMainObjectSchema">
                                SCHEMA</div>
                        </td>
                        <td>
                            <div id="divNewObject">
                                New Object</div>
                        </td>
                        <td>
                            <div id="divDefaults">
                                Defaults</div>
                        </td>
                    </tr>
                </table>
                <div id="divSourceObjectOuter">
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
