<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Tasks.ascx.cs" Inherits="Dnn.SPA.Tasks.Tasks" %>

<script type="text/javascript" src="/DesktopModules/Dnn/SPA.Tasks/Scripts/Tasks.js">

</script>
<div id="tasks" runat="Server" class="dnnTasks">
    <div class="dnnForm dnnEditTask dnnClear" id="dnnEditTask" data-bind="with: selectedTask, visible: editMode() == true">
	    <fieldset>
		    <div class="dnnFormItem">
		        <div class="dnnLabel">
			        <label for="name">Task:</label>
		        </div>
			    <input id="name" type="text" data-bind="value: name">
		    </div>
		    <div class="dnnFormItem">
		        <div class="dnnLabel">
			        <label for="name">Description:</label>
		        </div>
			    <input id="description" type="text" data-bind="value: description">
		    </div>
		    <div class="dnnFormItem">
		        <div class="dnnLabel">
			        <label for="name">IsComplete?</label>
		        </div>
			    <input id="isComplete" type="checkbox" data-bind="checked: isComplete">
		    </div>
		    <ul class="dnnActions dnnClear">
			    <li><input class="dnnPrimaryAction" type="submit" value="Save" data-bind="click: $parent.saveTask"></li>
			    <li><input class="dnnSecondaryAction" type="button" value="Cancel" data-bind="click: $parent.cancelTask"></li>
		    </ul>
	    </fieldset>
    </div>

    <div data-bind="visible: editMode() == false">
        <table cellspacing="0" class="dnnGrid dnnPermissionGrid">
            <thead>
            <tr class="dnnGridHeader">
                <td style="width:100px">Task</td>
                <td style="width:250px">Description</td>
                <td style="width:100px">Is Complete?</td>
                <td>Actions</td>
            </tr>
            </thead>
            <tbody data-bind="foreach: tasks">
            <tr data-bind="css: { dnnGridAltItem: $index()%2, dnnGridItem: $index()%2+1 }">
                <td class="permissionHeader"><span data-bind="text: name"></span></td>
                <td><span data-bind="text: description"></span></td>
                <td><span data-bind="text: isComplete"></span></td>
                <td class="DNNAligncenter">
                    <input src="<%=ControlPath %>images/Edit_16X16.png" type="image" data-bind="click: $parent.editTask">
                    &nbsp;&nbsp;
                    <input src="<%=ControlPath %>images/Delete_16x16.png" type="image" data-bind="click: $parent.removeTask">
                </td>
            </tr>
            </tbody>
        </table>
        <ul class="dnnActions dnnClear">
            <li><input class="dnnPrimaryAction"  type="submit" value="Add Task" data-bind="click: addTask"></li>
            <li><input class="dnnSecondaryAction"  type="button" value="Delete All Tasks" data-bind="click: clearTasks"></li>
        </ul>
    </div>    
</div>

<script type="text/javascript">
    
    /*globals jQuery, window, knockout */
    (function ($, ko) {
        function initialize() {
            var moduleId = <% = ModuleContext.Configuration.ModuleID %>;

            $('#<% = tasks.ClientID %>').tasks(ko, {
                moduleId: moduleId,
                servicesFramework: $.ServicesFramework(moduleId),
                serverErrorText: '<% = LocalizeSafeJsString("ServerError")%>',
                serverErrorWithDescriptionText: '<% = LocalizeSafeJsString("ServerErrorWithDescription")%>'
            });
       }

        $(document).ready(function () {
            initialize();
        });
        
    } (jQuery, ko));

</script>