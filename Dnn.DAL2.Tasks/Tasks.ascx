<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Tasks.ascx.cs" Inherits="Dnn.DAL2.Tasks.Tasks" %>

<asp:DataGrid ID="tasks" runat="server" AutoGenerateColumns="false" GridLines="None" CssClass="dnnTasks">
    <HeaderStyle CssClass="taskListHeader" />
    <ItemStyle CssClass="taskListRow"/>
    <Columns>
        <asp:BoundColumn DataField="Name" HeaderText="Name" HeaderStyle-Width="100px"/>
        <asp:BoundColumn DataField="Description" HeaderText="Description" HeaderStyle-Width="250px"/>
        <asp:BoundColumn DataField="IsComplete" HeaderText="Is Complete?" HeaderStyle-Width="125px"/>
    </Columns>
</asp:DataGrid>

