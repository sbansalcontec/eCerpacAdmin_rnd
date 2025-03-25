using eCerpac_NIS.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCerpac_NIS
{
    public partial class Dashboard : System.Web.UI.Page
    {
        DataTable dt_login_details = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            //dt_login_details = (DataTable)Session["LoginDetails"];

            ////   LabelSysDate.Text = DateTime.Now.ToLongDateString();
            //if (dt_login_details == null)
            //{
            //    // Response.Redirect("Login.aspx");

            //    Server.Transfer("Login.aspx", false);
            //}
          //  BindLeftMenu();
        }

        //public void BindLeftMenu()
        //{
        //    TVLeftMenu.Nodes.Clear();
        //    TreeNode CurrentNode = null;
        //    TreeNode tn = null;

        //    try
        //    {
        //        string fetchforms = "Select FormName, FormURL from UserMaster a, GroupFormRelation b, FormMaster c where a.GrpID=b.GrpId and b.FormID=c.FormID and  a.UserId='" + dt_login_details.Rows[0]["UserId"].ToString() + "' and c.FormStatus='A'   order by FormURL";
        //        DataTable DtFormInfo = new DataTable();
        //        DtFormInfo = CommonFunctions.fetchdata(fetchforms);

        //        if (DtFormInfo == null)
        //            return;

        //        if (DtFormInfo != null)
        //        {
        //            if (DtFormInfo.Rows.Count > 0)
        //            {
        //                //strSubmenu = DtFormInfo.Rows[0]["SUBMENU"].ToString();
        //            }
        //        }

        //        foreach (DataRow dr in DtFormInfo.Rows)
        //        {
        //            TreeNode rootNode = null;
        //            if (dr != null)
        //            {

        //                tn = new TreeNode();
        //                tn.Text = dr["FormName"].ToString();
        //                tn.NavigateUrl = (string)(dr.IsNull("FormUrl") ? "" : dr["FormUrl"]);
        //                string[] StrNavigateURL = new string[1];
        //                StrNavigateURL = tn.NavigateUrl.Split(new char[] { '/' });
        //                string[] StrCurrentURL = new string[1];
        //                StrCurrentURL = HttpContext.Current.Request.Path.Split(new char[] { '/' });
        //                if (StrNavigateURL[StrNavigateURL.Length - 1].Equals(StrCurrentURL[StrCurrentURL.Length - 1]))
        //                {
        //                    CurrentNode = rootNode;
        //                }
        //                if (rootNode != null)
        //                {
        //                    rootNode.ChildNodes.Add(tn);

        //                }
        //                else
        //                {

        //                    TVLeftMenu.Nodes.Add(tn);

        //                }

        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        //LabelMessageCss = "errormsg";
        //        //LabelMessage = ex.Message.ToString();
        //    }
        //}
    }
}