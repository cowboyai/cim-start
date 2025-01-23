use leptos::prelude::*;

#[component]
pub fn Nav() -> impl IntoView {
    view! {
        <nav>
            <div class="nav title"><h2>Command Center</h2></div>
            <ul>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-dashboard"></i>
                        "Dashboard"
                    </a>
                </li>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-arrows-to-circle"></i>
                        "Domain"
                    </a>
                </li>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-diagram-project"></i>
                        "Workflow"
                    </a>
                </li>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-comment"></i>
                        "Comms"
                    </a>
                </li>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-brain"></i>
                        "AI"
                    </a>
                </li>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-clipboard"></i>
                        "Notes"
                    </a>
                </li>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-file-waveform"></i>
                        "Docs"
                    </a>
                </li>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-gear"></i>
                        "Settings"
                    </a>
                </li>
            </ul>
        </nav>
    }
}
