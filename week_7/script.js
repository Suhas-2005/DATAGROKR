
function addTask() {
    const input = document.getElementById("taskInput");
    const taskText = input.value.trim();
    const message = document.getElementById("message");

    if (taskText === "") {
        message.textContent = "Please enter a task!";
        return;
    }

    message.textContent = "";

    const li = document.createElement("li");
    const span = document.createElement("span");
    span.textContent = taskText;

    const completeBtn = document.createElement("button");
    completeBtn.textContent = "Complete";

    completeBtn.onclick = function () {
        li.classList.toggle("completed");
        completeBtn.textContent = li.classList.contains("completed")
            ? "Undo"
            : "Complete";
    };

    const deleteBtn = document.createElement("button");
    deleteBtn.textContent = "Delete";
    deleteBtn.className = "delete";

    deleteBtn.onclick = function () {
        li.remove();
    };

    li.appendChild(span);
    li.appendChild(completeBtn);
    li.appendChild(deleteBtn);

    document.getElementById("taskList").appendChild(li);

    input.value = "";
    input.focus();
}
