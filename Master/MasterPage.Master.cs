using eCerpac_NIS.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCerpac_NIS.Master
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        DataTable dt_login_details = new DataTable();

        public string LabelMessage
        {
            get { return this.lblZoneCode.Text; }
            set { this.lblZoneCode.Text = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //DataTable dt_login_details = new DataTable();
            dt_login_details = (DataTable)Session["LoginDetails"];

         //   LabelSysDate.Text = DateTime.Now.ToLongDateString();
            if (dt_login_details == null)
            {
               // Response.Redirect("Login.aspx");

                Server.Transfer("Login.aspx", false);
            }


            if (dt_login_details != null && dt_login_details.Rows.Count > 0)
            {
                lbl_UserName.Text = dt_login_details.Rows[0]["Username"].ToString() ;
                lbl_UserName_header.Text = dt_login_details.Rows[0]["Username"].ToString() ;

                lbl_LoginID.Text = dt_login_details.Rows[0]["loginId"].ToString();

                BindLeftMenu();

                bindgrid();


            }
        }

        public void bindgrid()
        {

            try
            {


                string qry = " Select  AuditDate, convert(varchar, AuditDate, 100 ) as AuditDate1, MachineIP, MachineName    from AuditTrans where userid='" + dt_login_details.Rows[0]["UserId"].ToString() + "' order by AuditDate desc ";
                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(qry);
                if (dt.Rows.Count > 0)
                {
                    // lblZoneCode.Text = "";
                    LabelSysDate.Text = dt.Rows[0]["AuditDate1"].ToString(); ;
                }
            }
            catch (Exception ex)
            {

            }
        }

        //public void BindLeftMenu()
        //{
        //    TVLeftMenu.Nodes.Clear();
        //    TreeNode CurrentNode = null;
        //    //  TreeNode tn = null;

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

        //        //foreach (DataRow dr in DtFormInfo.Rows)
        //        //{
        //        //    TreeNode rootNode = null;
        //        //    if (dr != null)
        //        //    {

        //        //        tn = new TreeNode();
        //        //        tn.Text = dr["FormName"].ToString();
        //        //        tn.NavigateUrl = (string)(dr.IsNull("FormUrl") ? "" : dr["FormUrl"]);
        //        //        string[] StrNavigateURL = new string[1];
        //        //        StrNavigateURL = tn.NavigateUrl.Split(new char[] { '/' });
        //        //        string[] StrCurrentURL = new string[1];
        //        //        StrCurrentURL = HttpContext.Current.Request.Path.Split(new char[] { '/' });
        //        //        if (StrNavigateURL[StrNavigateURL.Length - 1].Equals(StrCurrentURL[StrCurrentURL.Length - 1]))
        //        //        {
        //        //            CurrentNode = rootNode;
        //        //        }
        //        //        if (rootNode != null)
        //        //        {
        //        //            rootNode.ChildNodes.Add(tn);

        //        //        }
        //        //        else
        //        //        {

        //        //            TVLeftMenu.Nodes.Add(tn);

        //        //        }

        //        //    }
        //        //}

        //        TreeNode rootNode = new TreeNode("Root");
        //        TVLeftMenu.Nodes.Add(rootNode);
        //        foreach (DataRow dr in DtFormInfo.Rows)
        //        {
        //            if (dr != null)
        //            {
        //                TreeNode tn = new TreeNode
        //                {
        //                    Text = dr["FormName"].ToString(),
        //                    NavigateUrl = dr.IsNull("FormUrl") ? "" : dr["FormUrl"].ToString()
        //                };

        //                string[] StrNavigateURL = tn.NavigateUrl.Split('/');
        //                string[] StrCurrentURL = HttpContext.Current.Request.Path.Split('/');

        //                // Ensure there is at least one element before accessing the last element
        //                if (StrNavigateURL.Length > 0 && StrCurrentURL.Length > 0 &&
        //                    StrNavigateURL[StrNavigateURL.Length - 1].Equals(StrCurrentURL[StrCurrentURL.Length - 1], StringComparison.OrdinalIgnoreCase))
        //                {
        //                    CurrentNode = tn;
        //                }

        //                // Assign the first node as the root node
        //                if (rootNode == null)
        //                {
        //                    rootNode = tn;
        //                    TVLeftMenu.Nodes.Add(rootNode);
        //                }
        //                else
        //                {
        //                    rootNode.ChildNodes.Add(tn);
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

        //    public void BindLeftMenu()
        //    {
        //        TVLeftMenu.Nodes.Clear();
        //        TreeNode CurrentNode = null;

        //        try
        //        {
        //            string fetchforms = "SELECT FormName, FormURL FROM UserMaster a " +
        //                                "JOIN GroupFormRelation b ON a.GrpID = b.GrpId " +
        //                                "JOIN FormMaster c ON b.FormID = c.FormID " +
        //                                "WHERE a.UserId = '" + dt_login_details.Rows[0]["UserId"].ToString() + "' AND c.FormStatus = 'A' ORDER BY FormURL";

        //            DataTable DtFormInfo = CommonFunctions.fetchdata(fetchforms);

        //            if (DtFormInfo == null || DtFormInfo.Rows.Count == 0)
        //                return;

        //            TreeNode rootNode = new TreeNode("eCerpac Menu");
        //            TVLeftMenu.Nodes.Add(rootNode);

        //            string currentUrl = HttpContext.Current.Request.Path;

        //            foreach (DataRow dr in DtFormInfo.Rows)
        //            {
        //                TreeNode tn = new TreeNode
        //                {
        //                    Text = dr["FormName"].ToString(),
        //                    NavigateUrl = dr.IsNull("FormUrl") ? "" : dr["FormUrl"].ToString()
        //                };

        //                // Check if the node is the current page
        //                string[] StrNavigateURL = tn.NavigateUrl.Split('/');
        //                string[] StrCurrentURL = currentUrl.Split('/');

        //                if (StrNavigateURL.Length > 0 && StrCurrentURL.Length > 0 &&
        //StrNavigateURL[StrNavigateURL.Length - 1].Equals(StrCurrentURL[StrCurrentURL.Length - 1], StringComparison.OrdinalIgnoreCase))
        //                {
        //                    CurrentNode = tn;
        //                    tn.Expand(); // Expand the current node
        //                }


        //                rootNode.ChildNodes.Add(tn);
        //            }
        //        }
        //        catch (Exception ex)
        //        {
        //            // Consider logging the error instead of suppressing it
        //            // Logger.LogError(ex);
        //        }
        //    }

        public void BindLeftMenu()
        {
            TVLeftMenu.Nodes.Clear();
            TreeNode CurrentNode = null;

            try
            {
                string fetchforms = "SELECT FormName, FormURL FROM UserMaster a " +
                                    "JOIN GroupFormRelation b ON a.GrpID = b.GrpId " +
                                    "JOIN FormMaster c ON b.FormID = c.FormID " +
                                    "WHERE a.UserId = '" + dt_login_details.Rows[0]["UserId"].ToString() + "' AND c.FormStatus = 'A' " +
                                    "ORDER BY FormURL";

                DataTable DtFormInfo = CommonFunctions.fetchdata(fetchforms);

                if (DtFormInfo == null || DtFormInfo.Rows.Count == 0)
                    return;

                string currentUrl = HttpContext.Current.Request.Path;

                foreach (DataRow dr in DtFormInfo.Rows)
                {
                    string formName = dr["FormName"].ToString();
                    string formUrl = dr.IsNull("FormUrl") ? "#" : dr["FormUrl"].ToString();

                    TreeNode tn = new TreeNode
                    {
                        Text = formName,
                        NavigateUrl = formUrl
                    };

                    // Highlight and expand the current page
                    if (!string.IsNullOrEmpty(formUrl) && currentUrl.EndsWith(formUrl, StringComparison.OrdinalIgnoreCase))
                    {
                        CurrentNode = tn;
                        tn.Expand();
                    }

                    TVLeftMenu.Nodes.Add(tn);
                }
            }
            catch (Exception ex)
            {
                // Consider logging the error instead of suppressing it
                // Logger.LogError(ex);
            }
        }



        protected void btnLogout(object sender, EventArgs e)
        {

            //---------Audit Details Capture ----------------

            string MachineIP = Request.UserHostAddress.ToString();
            string MachingName = System.Net.Dns.GetHostName();
            string WindowUser = HttpContext.Current.Request.LogonUserIdentity.Name;
            string AuditDetail = "User Login";
            string AuditType = "11";
            string UserID = dt_login_details.Rows[0]["Userid"].ToString();

            string L = CommonFunctions.LoginAudit(MachineIP, MachingName, WindowUser, AuditDetail, AuditType, UserID);
            Session["LoginId"] = null;
            Session["LoginDetails"] = null;
            Response.Redirect("Login.aspx");
        }
    }
}