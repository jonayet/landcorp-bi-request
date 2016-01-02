<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="View.aspx.cs" Inherits="BiRequestWeb.BIRequest.BiRequestView" %>

<%-- ReSharper disable Html.IdNotResolved --%>
<asp:Content ID="BiRequestForm" ContentPlaceHolderID="MainContent" runat="server">
    <fieldset>
        <legend>Business Intelligence Request Form</legend>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="nameOfRequestor" class="col-md-3 control-label">Name of Requestor</label>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" ClientIDMode="Static" ID="requestorName" ReadOnly="True" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="dateRequested" class="col-md-3 control-label">Date Requested</label>
                    <div class="col-md-3">
                        <asp:TextBox runat="server" ClientIDMode="Static" ID="dateRequested" ReadOnly="True" class="form-control" />
                    </div>

                    <label for="dateRequired" class="col-md-3 control-label">Date Required</label>
                    <div class="col-md-3">
                        <asp:TextBox runat="server" ClientIDMode="Static" ID="dateRequired" ReadOnly="True" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="executiveSponsor" class="col-md-3 control-label">Executive Sponsor</label>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" ClientIDMode="Static" ID="executiveSponsor" ReadOnly="True" class="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="requestName" class="col-md-3 control-label">Request Name</label>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" ClientIDMode="Static" ID="requestName" ReadOnly="True" class="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="requestType" class="col-md-3 control-label">Request Type</label>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" ClientIDMode="Static" ID="requestType" ReadOnly="True" class="form-control" />
                    </div>
                </div>

                <div class="clearfix"></div>

                <div class="form-group">
                    <div class="col-md-3">
                        <label for="natureOfRequest" class="control-label">What is the nature of the request?</label>
                    </div>

                    <div class="col-md-9">
                        <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="natureOfRequest" ReadOnly="True" class="form-control" Rows="4" />
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-md-3">
                        <label for="informationRequired" class="control-label">What information do you require?</label>

                    </div>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="informationRequired" ReadOnly="True" class="form-control" Rows="4" />
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <div class="col-md-3">
                        <label for="parametersRequired" class="control-label">What parameters are required?</label>
                    </div>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="parametersRequired" ReadOnly="True" class="form-control" Rows="3" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-3">
                        <label for="groupingRequirements" class="control-label">Please indicate any sorting/order/ grouping requirements</label>
                    </div>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="groupingRequirements" ReadOnly="True" class="form-control" Rows="3" />
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-md-3">
                        <label for="peopleToShare" class="control-label">Who do you want to access the information?</label>
                    </div>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="peopleToShare" ReadOnly="True" class="form-control" Rows="4" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="additionalComments" class="col-md-3 control-label">Comments</label>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="comments" ReadOnly="True" class="form-control" Rows="4" />
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <div class="col-md-3">
                        <label for="informationRequired" class="control-label">Attachments</label>
                    </div>
                    <div class="col-md-9">
                        <asp:Table runat="server" ClientIDMode="Static" ID="tblAttachments" />
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
    
    <fieldset>
        <legend>Business Intelligence Section: Internal use only</legend>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="dateReviewed" class="col-md-3 control-label">Date Reviewed</label>
                    <div class="col-md-3">
                        <asp:TextBox runat="server" ClientIDMode="Static" ID="dateReviewed" ReadOnly="True" class="form-control date" />
                    </div>

                    <label for="estimatedHours" class="col-md-3 control-label">Estimated Hours</label>
                    <div class="col-md-3">
                        <asp:TextBox runat="server" ClientIDMode="Static" ID="estimatedHours" ReadOnly="True" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="businessCaseID" class="col-md-3 control-label">Business Case ID</label>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" ClientIDMode="Static" ID="businessCaseID" ReadOnly="True"  class="form-control" />
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="internalComments" class="col-md-3 control-label">Approval Comments</label>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="approvalComments" ReadOnly="True" class="form-control" Rows="3" />
                    </div>
                </div>
            </div>
        </div>
    </fieldset>

    <fieldset disabled>
        <legend>Sign Off Process (Change Control)</legend>
        <table class="table">
            <thead>
                <tr>
                    <th>Approval</th>
                    <th>Name</th>
                    <th>Signature</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th scope="row">Executive Sponsor</th>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <th scope="row">Development</th>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <th scope="row">User Acceptance Testing</th>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <th scope="row">Release</th>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </fieldset>
    
    <script>
        $(function () {
            $('#tblAttachments > tbody > tr').click(function () {
                $(this, 'tr').each(function(index, tr) {
                    var lines = $('td', tr).map(function(index, td) {
                        return $(td).text();
                    });
                    var attachmentId = lines[1];
                    window.open("/download/" + attachmentId, '_blank');
                });
            });
        });
    </script>
</asp:Content>
