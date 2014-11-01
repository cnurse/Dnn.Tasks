/*
The MIT License (MIT)

Copyright (c) 2014 Charles Nurse

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */
(function ($) {
    
    $.fn.tasks = function (ko, options) {
        //default settings
        var settings = {
            moduleId: -1
        };

        settings = $.extend(settings, options || {});
        var $self = this;
        
        var serviceFramework = settings.servicesFramework;
        var baseServicepath = serviceFramework.getServiceRoot('Dnn/SPA.Tasks') + 'TaskService/';
        var moduleId = settings.moduleId;
        
        function displayMessage(message, cssclass) {
            var messageNode = $("<div/>").addClass('dnnFormMessage ' + cssclass).text(message);
            $self.prepend(messageNode);
            messageNode.fadeOut(3000, 'easeInExpo', function () { messageNode.remove(); });
        };

        getTasks();
        
        //View Models
        //item is a JS object
        function TaskViewModel(item) {
            var self = this;
            self.taskId = ko.observable(item.TaskID);
            self.name = ko.protectedObservable(item.Name);
            self.description = ko.protectedObservable(item.Description);
            self.isComplete = ko.protectedObservable(item.IsComplete);

            self.commitAll = function () {
                self.name.commit();
                self.description.commit();
                self.isComplete.commit();
            };

            self.resetAll = function() {
                self.name.reset();
                self.description.reset();
                self.isComplete.reset();
            };
        }

        function TasksViewModel(items) {
            var self = this;
            var addMode = false;

            var tasks = new Array();
            for (i = 0; i < items.length; i++) {
                tasks.push(new TaskViewModel(items[i]));
            }
            self.tasks = ko.observableArray(tasks);

            self.editMode = ko.observable(false);
            self.selectedTask = ko.observable();

            self.addTask = function () {
                var newTask = new TaskViewModel({
                    name: '',
                    description: '',
                    isComplete: false
                });
                addMode = true;
                self.editMode(true);
                self.tasks.push(newTask);
                self.selectedTask(newTask);
            };

            self.cancelTask = function (task) {
                if (addMode === true) {
                    self.tasks.remove(task);
                }
                else {
                    task.resetAll();
                }
                self.editMode(false);
            };

            self.clearTasks = function() {
                deleteAllTasks();

                self.tasks.removeAll();
            };

            self.editTask = function (task) {
                addMode = false;
                self.editMode(true);
                self.selectedTask(task);
            };

            self.removeTask = function (task) {
                self.tasks.remove(task);

                //update data store
                deleteTask(task);
            };

            self.saveTask = function (task) {
                //commit changes
                task.commitAll();

                //update data store
                if (addMode === true) {
                    createTask(task);
                }
                else {
                    updateTask(task);
                }

                //reset mode
                self.editMode(false);
            };
        }

        //Business/Data Layer (CRUD)
        function createTask(task) {
            $.ajax({
                type: "POST",
                cache: false,
                url: baseServicepath + 'CreateTask',
                beforeSend: serviceFramework.setModuleHeaders,
                data: {
                    Name: task.name,
                    Description: task.description,
                    IsComplete: task.isComplete
                }
            }).done(function (data) {
                if (data.Result !== "success") {
                    displayMessage(settings.serverErrorText, "dnnFormWarning");
                }
                else {
                    task.taskId(data.TaskId);
                }
            }).fail(function (xhr, status) {
                displayMessage(settings.serverErrorWithDescriptionText + status, "dnnFormWarning");
            });
        }
        
        function deleteAllTasks() {
            $.ajax({
                type: "POST",
                cache: false,
                url: baseServicepath + 'DeleteAllTasks',
                beforeSend: serviceFramework.setModuleHeaders
            }).done(function (data) {
                if (data.Result !== "success") {
                    displayMessage(settings.serverErrorText, "dnnFormWarning");
                }
            }).fail(function (xhr, status) {
                displayMessage(settings.serverErrorWithDescriptionText + status, "dnnFormWarning");
            });
        }

        function deleteTask(task) {
            $.ajax({
                type: "POST",
                cache: false,
                url: baseServicepath + 'DeleteTask',
                beforeSend: serviceFramework.setModuleHeaders,
                data: {
                    TaskId: task.taskId,
                    Name: task.name,
                    Description: task.description,
                    IsComplete: task.isComplete
                }
            }).done(function (data) {
                if (data.Result !== "success") {
                    displayMessage(settings.serverErrorText, "dnnFormWarning");
                }
            }).fail(function (xhr, status) {
                displayMessage(settings.serverErrorWithDescriptionText + status, "dnnFormWarning");
            });
        }

        function getTasks() {
            //Get a JS array of Task items
           
            $.ajax({
                type: "GET",
                cache: false,
                url: baseServicepath + "GetTasks",
                beforeSend: serviceFramework.setModuleHeaders
            }).done(function (items) {
                if (typeof items !== "undefined" && items != null) {
                    ko.applyBindings(new TasksViewModel(items), $self[0]);
                } else {
                    displayMessage(settings.serverErrorText, "dnnFormWarning");
                }
            }).fail(function (xhr, status) {
                displayMessage(settings.serverErrorWithDescriptionText + status, "dnnFormWarning");
            });
        };

        function updateTask(task) {
            $.ajax({
                type: "POST",
                cache: false,
                url: baseServicepath + 'UpdateTask',
                beforeSend: serviceFramework.setModuleHeaders,
                data: {
                    TaskId: task.taskId,
                    Name: task.name,
                    Description: task.description,
                    IsComplete: task.isComplete
                }
            }).done(function (data) {
                if (data.Result !== "success") {
                    displayMessage(settings.serverErrorText, "dnnFormWarning");
                }
            }).fail(function (xhr, status) {
                displayMessage(settings.serverErrorWithDescriptionText + status, "dnnFormWarning");
            });
        }

        return $self;
    };
    
    //Protected Observable: Ryan Niemeyer (www.knockmeout.com)
    //wrapper to an observable that requires accept/cancel
    ko.protectedObservable = function (initialValue) {
        //private variables
        var _actualValue = ko.observable(initialValue);
        var _tempValue = initialValue;

        //computed observable that we will return
        var result = ko.computed({
            //always return the actual value
            read: function () {
                return _actualValue();
            },
            //stored in a temporary spot until commit
            write: function (newValue) {
                _tempValue = newValue;
            }
        });

        //if different, commit temp value
        result.commit = function () {
            if (_tempValue !== _actualValue()) {
                _actualValue(_tempValue);
            }
        };

        //force subscribers to take original
        result.reset = function () {
            _actualValue.valueHasMutated();
            _tempValue = _actualValue();   //reset temp value
        };

        return result;
    };
    
})(jQuery);