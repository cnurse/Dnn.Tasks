<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditTask.ascx.cs" Inherits="Dnn.WebForms.Tasks.EditTask" %>
<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/LabelControl.ascx" %>

<div class="dnnForm dnnEditTask dnnClear" id="dnnEditTask">
	<fieldset>
		<div class="dnnFormItem">
			<dnn:label id="taskNameLabel" runat="server" controlname="taskNameTextBox"/>
			<asp:TextBox ID="taskName" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn:label id="taskDescriptionLabel" runat="server" controlname="taskDescription"/>
			<asp:TextBox ID="taskDescription" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn:label id="isCompleteLabel" runat="server" controlname="isComplete" />
			<asp:checkbox id="isComplete" runat="server" />
		</div>
		<ul class="dnnActions dnnClear">
			<li><asp:LinkButton id="saveTask" runat="server" class="dnnPrimaryAction" resourcekey="save" /></li>
			<li><asp:HyperLink id="hlCancel" runat="server" class="dnnSecondaryAction" resourcekey="cancel" /></li>
		</ul>
	</fieldset>
</div>
