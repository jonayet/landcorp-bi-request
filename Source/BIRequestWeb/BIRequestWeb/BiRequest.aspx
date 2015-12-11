<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BiRequest.aspx.cs" Inherits="BiRequestWeb.BiRequest" %>

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
                <label for="" class="col-md-3 control-label">Name of Requestor</label>
                <div class="col-md-9">
                    <input type="text" class="form-control" id="nameOfRequestor" placeholder="Name of Requestor">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="col-md-3 control-label">Date Requested</label>
                <div class="col-md-3">
                    <input type="text" class="form-control date" id="dateRequested">
                </div>

                <label for="" class="col-md-3 control-label">Date Required</label>
                <div class="col-md-3">
                    <input type="text" class="form-control date" id="dateRequired">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="col-md-3 control-label">Executive Sponsor</label>
                <div class="col-md-9">
                    <input type="text" class="form-control" id="executiveSponsor" placeholder="Executive Sponsor">
                </div>
            </div>

            <hr />
            <div class="form-group">
                <label for="" class="col-md-3 control-label">Request Name</label>
                <div class="col-md-9">
                    <textarea class="form-control" rows="3" placeholder="Request Name"></textarea>
                </div>
            </div>

            <hr />
            <label for="" class="col-md-3 control-label">Request Type</label>
            <div class="col-md-9">
                <label class="radio-inline">
                    <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1">
                    New Request
                </label>
                <label class="radio-inline">
                    <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
                    Modification
                </label>
                <label class="radio-inline">
                    <input type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option3">
                    Enhancement
                </label>
                <label class="radio-inline">
                    <input type="radio" name="inlineRadioOptions" id="inlineRadio4" value="option4">
                    Replacement
                </label>
            </div>

            <div class="clearfix"></div>

            <hr />
            <div class="form-group">
                <div class="col-md-4">
                    <label class="control-label">What is the nature of the request?</label>
                    <p class="text-muted text-right">Enter a brief description of the requirements</p>
                </div>

                <div class="col-md-8 col-sm">
                    <textarea class="form-control" rows="4" id="txFive"
                        placeholder="Enter a brief description of the requirements"></textarea>
                    <p class="small text-muted">You have <span id="ctxFive"></span>letters left.</p>
                </div>
            </div>

            <hr />
            <div class="form-group">
                <div class="col-md-4">
                    <label class="control-label">What information do you require?</label>
                    <p class="text-muted text-right">
                        Please supply a mocked up version of the request and
                            list the fields that you want displayed. Is there a current report
                            you would like this based on?
                    </p>
                </div>
                <div class="col-md-8">
                    <textarea class="form-control" rows="4" id="txFour"
                        placeholder="Is there a current report you'd like this based on?"></textarea>
                    <p class="small text-muted">You have <span id="ctxFour"></span>letters left.</p>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="form-group">
                <div class="col-md-4">
                    <label class="control-label">What parameters are required?</label>
                    <p class="text-muted text-right">e.g. Farm, date range etc.</p>
                </div>
                <div class="col-md-8">
                    <textarea class="form-control" rows="4" id="txThree"
                        placeholder="E.g. Farm, date range etc."></textarea>
                    <p class="small text-muted">You have <span id="ctxThree"></span>letters left.</p>
                </div>
            </div>

            <hr />
            <div class="form-group">
                <div class="col-md-4">
                    <label class="control-label">Please indicate any sorting/order/grouping requirements</label>
                    <p class="text-muted text-right">e.g. sort alphabetically, group by department</p>
                </div>
                <div class="col-md-8">
                    <textarea class="form-control" rows="4" id="txTwo"
                        placeholder="e.g. sort alphabetically, group by department"></textarea>
                    <p class="small text-muted">You have <span id="ctxTwo"></span>letters left.</p>
                </div>
            </div>

            <hr />
            <div class="form-group">
                <div class="col-md-4">
                    <label class="control-label">Who do you want to access the information?</label>
                    <p class="text-muted text-right">List all people or groups of people we will have permissions to run the report</p>
                </div>
                <div class="col-md-8">
                    <textarea class="form-control" rows="4" id="txOne"
                        placeholder="List all people or groups of people we will have permissions to run the report"></textarea>
                    <p class="small text-muted">You have <span id="ctxOne"></span>letters left.</p>
                </div>
            </div>

            <hr />
            <div class="form-group">
                <label class="col-md-4 control-label">Additional Comments:</label>
                <div class="col-md-8">
                    <textarea class="form-control" rows="4" id="additionalComments"
                        placeholder="Additional Comments:"></textarea>
                    <p class="small text-muted">You have <span id="counterAdditionalComments"></span>letters left.</p>
                </div>
            </div>
        </div>
    </div>
    <hr />

    <div class="row">
        <div class="col-lg-9">
            <h3>Business Intelligence Section: Internal use only</h3>
        </div>
    </div>
    <hr />

    <div class="row">
        <div class="col-lg-6">
            <div class="form-group">
                <label for="" class="col-sm-3 control-label">Date Reviewed</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control date" id="dateReviewed" placeholder="">
                </div>

                <label for="" class="col-sm-3 control-label">Estimated Hours</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="" placeholder="Hours">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="col-sm-3 control-label">Business Case ID</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="" placeholder="Business Case ID">
                </div>
            </div>
            <hr />

            <table class="table">
                <caption>Sign Off Process (Change Control)</caption>
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
        </div>
        <div class="col-lg-6">
            <div class="form-group">
                <label class="col-sm-4 control-label">Comments:</label>
                <div class="col-sm-8">
                    <textarea class="form-control" rows="4" id="txSix"
                        placeholder="Additional Comments:"></textarea>
                    <p class="small text-muted">You have <span id="ctxSix"></span>letters left.</p>
                </div>
            </div>
        </div>
    </div>
    <hr />

    <div class="row">
        <div class="col-lg-12">
            <button type="button" class="btn btn-primary btn-lg">Submit Form</button>
            <hr />
        </div>
    </div>



    <div class="form-group">
        <label for="" class="col-md-3 control-label">Name of Requestor</label>
        <div class="col-md-9">
            <asp:TextBox runat="server" ID="NameBox" class="form-control" ClientIDMode="Static" placeholder="Name of Requestor" />
        </div>
    </div>

    <p>
        <asp:Label runat="server" ID="TextBox1" />
        <input type="submit" value="Submit" />
    </p>

    <script>
        $(".date").datepicker({
            autoclose: true
        });
    </script>
</asp:Content>
