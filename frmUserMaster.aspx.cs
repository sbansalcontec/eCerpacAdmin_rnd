using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCerpac_NIS
{
    public partial class frmUserMaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //Select A.UserID, LoginID, Password, USerName, ZoneName, C.ZoneCode, A.GrpCode, D.GrpName  From usermaster A, UserZoneRelation B, zonemaster C, GroupMaster D
            //where A.Userid = B.Userid and B.ZoneCode = c.ZoneCode and A.GrpID = D.GrpId and A.UserStatus = 'A' order by  C.ZoneCode,  D.GrpName
        }
    }
}