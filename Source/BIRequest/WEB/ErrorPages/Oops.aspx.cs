using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class _Oops : System.Web.UI.Page
{
    protected void lbl_DetailsHeader_Load(object sender, EventArgs e)
    {
        Label lbl = sender as Label;
        string ErrorMessage = "";
        if (Session["ErrorMessage"] != null)
        {
            ErrorMessage = Session["ErrorMessage"].ToString();
        }
        lbl.Text = ErrorMessage;
    }

    protected void lbl_Details_Load(object sender, EventArgs e)
    {
        Label lbl = sender as Label;
        string InnerException = "No details available";
        if (Session["InnerException"] != null)
        {
            InnerException = Session["InnerException"].ToString();
        }
        lbl.Text = InnerException;
    }
}