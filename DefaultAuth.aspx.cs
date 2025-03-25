
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;


namespace eCerpac_NIS
{
    public partial class DefaultAuth : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            
        //string confirmValue = Request.Form["confirm_closingValue"];
        //if (confirmValue == "CONFIRM")
        //{
        //    this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('You clicked CONFIRM!')", true);
        //}
        //else
        //{
        //    this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('You clicked CANCEL!')", true);
        //}
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "confirm_closing()", false);

            string confirm_closingValue = Request.Form["confirmValue"];
            if (confirm_closingValue == "CONFIRM")
            {

                //Do Something
            }
            else
            {
                //Do Something Else
            }

            // ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('On OK, Click you will be redirect to new Page'); window.location = '" + Page.ResolveUrl("~/DefaultAuth.aspx") + "';", true);

            //string message = "Your details have been saved successfully.";
            //StringBuilder sb = new StringBuilder();
            //sb.Append("<script type='text/javascript'>");
            //sb.Append("window.onload = function(){ alert('");
            //sb.Append(message);
            //sb.Append("')};");
            //sb.Append("</script>");
            //ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", sb.ToString());
        }
    }
}