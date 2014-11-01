<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Tasks.ascx.cs" Inherits="Dnn.WebForms.Tasks.Tasks" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>

<div class="dnnTasks">
    <div>
        <asp:DataGrid ID="tasks" runat="server" AutoGenerateColumns="false" GridLines="None" CssClass="dnnGrid dnnPermissionGrid">
            <HeaderStyle CssClass="dnnGridHeader" />
            <ItemStyle CssClass="dnnGridItem" />
            <AlternatingItemStyle CssClass="dnnGridAltItem" />
            <Columns>
                <asp:BoundColumn DataField="Name" HeaderText="Name" HeaderStyle-Width="100px" />
                <asp:BoundColumn DataField="Description" HeaderText="Description" HeaderStyle-Width="250px" />
                <asp:BoundColumn DataField="IsComplete" HeaderText="Is Complete?" HeaderStyle-Width="100px" />
                <asp:TemplateColumn HeaderText="Actions">
                    <ItemTemplate>
                        <asp:HyperLink runat="server">
                            <asp:Image runat="server" ImageUrl="images/Edit_16X16.png"/>
                        </asp:HyperLink>
                        &nbsp;&nbsp;
                        <asp:ImageButton ID="deleteTask" runat="server" ImageUrl="images/Delete_16x16.png" CommandName="Delete" />
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>

        <ul class="dnnActions dnnClear">
            <li><asp:HyperLink ID="addTask" runat="server" CssClass="dnnPrimaryAction" Text="Add Task" /></li>
<%--            <li><asp:LinkButton runat="server" CssClass="dnnSecondaryAction" Text="Delete All Tasks" /></li>--%>
        </ul>
    </div>
</div>


<script language="javascript" type="text/javascript">
    /*globals jQuery, window, Sys */
    (function ($, Sys) {
        function setUpDnnUsers() {
            $("input[name$='deleteTask']").dnnConfirm({
                text: '<%= Localization.GetSafeJSString("DeleteTask.Text") %>',
                yesText: '<%= Localization.GetSafeJSString("Yes.Text", Localization.SharedResourceFile) %>',
                noText: '<%= Localization.GetSafeJSString("No.Text", Localization.SharedResourceFile) %>',
                title: '<%= Localization.GetSafeJSString("Confirm.Text", Localization.SharedResourceFile) %>'
            });
        }

        $(document).ready(function () {
            setUpDnnUsers();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpDnnUsers();
            });
        });
    }(jQuery, window.Sys));
</script>