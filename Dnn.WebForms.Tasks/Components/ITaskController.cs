using System.Collections.Generic;

namespace Dnn.WebForms.Tasks.Components
{
    public interface ITaskController
    {
        int AddTask(Task task);

        void DeleteTask(Task task);

        Task GetTask(int taskId);

        IEnumerable<Task> GetTasks(int moduleId);

        void UpdateTask(Task task);
    }
}