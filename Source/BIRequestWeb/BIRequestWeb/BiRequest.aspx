<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BiRequest.aspx.cs" Inherits="BiRequestWeb.BiRequest" %>

<%-- ReSharper disable Html.IdNotResolved --%>
<asp:Content ID="BiRequestForm" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-9">
            <h1>Business Intelligence Request Form</h1>
        </div>
    </div>
    <hr />

    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label for="nameOfRequestor" class="col-md-3 control-label">Name of Requestor</label>
                <div class="col-md-9">
                    <asp:TextBox runat="server" ClientIDMode="Static" ID="nameOfRequestor" class="form-control twitter-typeahead" placeholder="Name of Requestor" />
                </div>
            </div>
            <div class="form-group">
                <label for="dateRequested" class="col-md-3 control-label">Date Requested</label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ClientIDMode="Static" ID="dateRequested" class="form-control date" placeholder="Date Requested" />
                </div>

                <label for="dateRequired" class="col-md-3 control-label">Date Required</label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ClientIDMode="Static" ID="dateRequired" class="form-control date" placeholder="Date Required" />
                </div>
            </div>
            <div class="form-group">
                <label for="executiveSponsor" class="col-md-3 control-label">Executive Sponsor</label>
                <div class="col-md-9">
                    <asp:TextBox runat="server" ClientIDMode="Static" ID="executiveSponsor" class="form-control twitter-typeahead" placeholder="Executive Sponsor" />
                </div>
            </div>

            <div class="form-group">
                <label for="requestName" class="col-md-3 control-label">Request Name</label>
                <div class="col-md-9">
                    <asp:TextBox runat="server" ClientIDMode="Static" ID="requestName" class="form-control" placeholder="Request Name" />
                </div>
            </div>

            <div class="form-group">
                <label for="requestType" class="col-md-3 control-label">Request Type</label>
                <div class="col-md-9">
                    <asp:DropDownList runat="server" ClientIDMode="Static" ID="requestType" class="form-control">
                    </asp:DropDownList>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="form-group">
                <div class="col-md-3">
                    <label for="natureOfRequest" class="control-label">What is the nature of the request?</label>
                </div>

                <div class="col-md-9">
                    <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="natureOfRequest" class="form-control" Rows="4"
                        placeholder="Enter a brief description of the requirements" />
                    <p class="small text-muted">You have <span id="natureOfRequestCounter"></span>&nbsp;letters left.</p>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-3">
                    <label for="informationRequired" class="control-label">What information do you require?</label>

                </div>
                <div class="col-md-9">
                    <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="informationRequired" class="form-control" Rows="4"
                        placeholder="Supply a mocked up version of the request and list the fields that you want displayed." />
                    <p class="small text-muted">You have <span id="informationRequiredCounter"></span>&nbsp;letters left.</p>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="form-group">
                <div class="col-md-3">
                    <label for="parametersRequired" class="control-label">What parameters are required?</label>
                </div>
                <div class="col-md-9">
                    <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="parametersRequired" class="form-control" Rows="3"
                        placeholder="E.g. Farm, date range etc." />
                    <p class="small text-muted">You have <span id="parametersRequiredCounter"></span>&nbsp;letters left.</p>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-3">
                    <label for="groupingRequirements" class="control-label">Please indicate any sorting/order/ grouping requirements</label>
                </div>
                <div class="col-md-9">
                    <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="groupingRequirements" class="form-control" Rows="3"
                        placeholder="e.g. sort alphabetically, group by department" />
                    <p class="small text-muted">You have <span id="groupingRequirementsCounter"></span>&nbsp;letters left.</p>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-3">
                    <label for="peopleToShare" class="control-label">Who do you want to access the information?</label>
                </div>
                <div class="col-md-9">
                    <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="peopleToShare" class="form-control" Rows="4"
                        placeholder="List all people or groups of people we will have permissions to run the report" />
                    <p class="small text-muted">You have <span id="peopleToShareCounter"></span>&nbsp;letters left.</p>
                </div>
            </div>

            <div class="form-group">
                <label for="additionalComments" class="col-md-3 control-label">Additional Comments:</label>
                <div class="col-md-9">
                    <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="additionalComments" class="form-control" Rows="4"
                        placeholder="Additional Comments" />
                    <p class="small text-muted">You have <span id="additionalCommentsCounter"></span>&nbsp;letters left.</p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-9">
            <h3>Business Intelligence Section: Internal use only</h3>
        </div>
    </div>
    <hr />

    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label for="dateReviewed" class="col-md-3 control-label">Date Reviewed</label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ClientIDMode="Static" ID="dateReviewed" class="form-control date" placeholder="Date Reviewed" />
                </div>

                <label for="estimatedHours" class="col-md-3 control-label">Estimated Hours</label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ClientIDMode="Static" ID="estimatedHours" class="form-control" placeholder="Estimated Hours" />
                </div>
            </div>
            <div class="form-group">
                <label for="businessCaseID" class="col-md-3 control-label">Business Case ID</label>
                <div class="col-md-9">
                    <asp:TextBox runat="server" ClientIDMode="Static" ID="businessCaseID" class="form-control" placeholder="Business Case ID" />
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label for="internalComments" class="col-md-3 control-label">Comments:</label>
                <div class="col-md-9">
                    <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="internalComments" class="form-control" Rows="3"
                        placeholder="Comments" />
                    <p class="small text-muted">You have <span id="internalCommentsCounter"></span>&nbsp;letters left.</p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-9">
            <h3>Sign Off Process (Change Control)</h3>
        </div>
    </div>
    <hr />
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

    <div class="row">
        <div class="col-md-12">
            <button type="submit" class="btn btn-primary btn-lg">Submit Form</button>
        </div>
    </div>

    <script>
        $(function () {
            $(".date").datepicker({
                autoclose: true
            });

            $("#natureOfRequest").simplyCountable({ strictMax: true, maxCount: 4000, counter: '#natureOfRequestCounter' });
            $("#informationRequired").simplyCountable({ strictMax: true, maxCount: 4000, counter: '#informationRequiredCounter' });
            $("#parametersRequired").simplyCountable({ strictMax: true, maxCount: 4000, counter: '#parametersRequiredCounter' });
            $("#groupingRequirements").simplyCountable({ strictMax: true, maxCount: 4000, counter: '#groupingRequirementsCounter' });
            $("#peopleToShare").simplyCountable({ strictMax: true, maxCount: 4000, counter: '#peopleToShareCounter' });
            $("#additionalComments").simplyCountable({ strictMax: true, maxCount: 4000, counter: '#additionalCommentsCounter' });
            $("#internalComments").simplyCountable({ strictMax: true, maxCount: 4000, counter: '#internalCommentsCounter' });

            function typeaheadData(query, sync, async) {
                $.ajax({
                    url: '/BirequestWebService.asmx/SearchUser',
                    type: 'POST',
                    data: { query: query },
                    success: function (data) {
                        async(data);
                    }
                });
            }

            $('.twitter-typeahead').typeahead({
                highlight: true
            },
            {
                name: 'users',
                display: 'FullName',
                source: typeaheadData,
                limit: 6
            });
        });
    </script>
</asp:Content>
