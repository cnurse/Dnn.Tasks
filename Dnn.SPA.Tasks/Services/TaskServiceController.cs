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

using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Dnn.SPA.Tasks.Components;
using DotNetNuke.Data;
using DotNetNuke.Security;
using DotNetNuke.Web.Api;

namespace Dnn.SPA.Tasks.Services
{
    [SupportedModules("Dnn.SPA.Tasks")]
    [DnnModuleAuthorize(AccessLevel = SecurityAccessLevel.View)]
    [TaskActionFilter]
    [ServiceException]
    public class TaskServiceController : DnnApiController
    {
        public IDataContext DataContext { get; set; }

        #region DTOs

        public class TaskDTO
        {
            public int TaskId { get; set; }
            public string Name { get; set; }
            public string Description { get; set; }
            public bool IsComplete { get; set; }
        }

        #endregion

        [HttpPost]
        public HttpResponseMessage CreateTask(TaskDTO taskDTO)
        {
            var repo = DataContext.GetRepository<Task>();
            var task = new Task
            {
                ModuleID = ActiveModule.ModuleID
            };
            UpdateTask(task, taskDTO);
            repo.Insert(task);

            return Request.CreateResponse(HttpStatusCode.OK, new { TaskId = task.TaskID, Result = "success" });
        }

        [HttpPost]
        [DnnExceptionFilter(MessageKey = "DeleteTask.Error")]
        public HttpResponseMessage DeleteTask(TaskDTO taskDTO)
        {
            var repo = DataContext.GetRepository<Task>();
            var task = repo.GetById(taskDTO.TaskId, ActiveModule.ModuleID);

            repo.Delete(task);
            var result = new {Result = "success"};
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        [HttpPost]
        public HttpResponseMessage DeleteAllTasks()
        {
            var repo = DataContext.GetRepository<Task>();

            foreach (Task task in repo.Get(ActiveModule.ModuleID))
            {
                repo.Delete(task);
            }

            return Request.CreateResponse(HttpStatusCode.OK, new { Result = "success" });
        }

        [HttpGet]
        public HttpResponseMessage GetTasks()
        {
            return Request.CreateResponse(HttpStatusCode.OK, DataContext.GetRepository<Task>().Get(ActiveModule.ModuleID));
        }

        [HttpPost]
        public HttpResponseMessage UpdateTask(TaskDTO taskDTO)
        {
            var repo = DataContext.GetRepository<Task>();
            var task = repo.GetById(taskDTO.TaskId, ActiveModule.ModuleID);
            UpdateTask(task, taskDTO);
            repo.Update(task);

            return Request.CreateResponse(HttpStatusCode.OK, new { Result = "success" });
        }

        #region Private Methods

        private void UpdateTask(Task task, TaskDTO taskDTO)
        {
            task.Name = taskDTO.Name;
            task.Description = taskDTO.Description;
            task.IsComplete = taskDTO.IsComplete;
        }

        #endregion
    }
}