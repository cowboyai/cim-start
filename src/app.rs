use leptos::prelude::*;
use leptos_meta::{provide_meta_context, MetaTags, Stylesheet, Title};
use leptos_router::{
    components::{Route, Router, Routes},
    StaticSegment,
};

pub fn shell(options: LeptosOptions) -> impl IntoView {
    view! {
        <!DOCTYPE html>
        <html lang="en">
            <head>
                <meta charset="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <AutoReload options=options.clone() />
                <HydrationScripts options/>
                <MetaTags/>
                <link rel="preconnect" href="https://fonts.googleapis.com" />
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
                <link href="https://fonts.googleapis.com/css2?family=Lexend+Giga:wght@100..900&display=swap" rel="stylesheet" />
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />
            </head>
            <body>
                <App/>
            </body>
        </html>
    }
}

#[component]
pub fn App() -> impl IntoView {
    // Provides context that manages stylesheets, titles, meta tags, etc.
    provide_meta_context();

    view! {
        // injects a stylesheet into the document <head>
        // id=leptos means cargo-leptos will hot-reload this stylesheet
        <Stylesheet id="leptos" href="/pkg/cim.css"/>

        // sets the document title
        <Title text="cim"/>

        // content for this welcome page
        <Router>
            <main>
                <Routes fallback=|| "Page not found.".into_view()>
                    <Route path=StaticSegment("") view=HomePage/>
                </Routes>
            </main>
        </Router>
    }
}

/// Renders the home page of your application.
#[component]
fn HomePage() -> impl IntoView {
    view! {
          <Header/>
          <div id="main">
            <Article>
                <TextIn/>
            </Article>
            <Nav/>
            <Aside>
                <a href="#">"Contextual Links"</a>
            </Aside>
          </div>
          <footer>"Copyright (c) 2025 - Cowboy AI"</footer>
    }
}

#[component]
fn Nav() -> impl IntoView {
    view! {
        <nav>
            <ul>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-home"></i>
                        "home"
                    </a>
                </li>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-rocket"></i>
                        "about"
                    </a>
                </li>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-envelope"></i>
                        "contact"
                    </a>
                </li>
            </ul>
        </nav>
    }
}

#[component]
fn Aside(children: Children) -> impl IntoView {
    view! {
        <aside>
            <ul>
            {children()}
            </ul>
        </aside>
    }
}

#[component]
fn Article(children: Children) -> impl IntoView {
    view! {
        <article>
            {children()}
        </article>
    }
}

#[component]
fn Masthead() -> impl IntoView {
    view! {
        <div class="masthead">
            "CIM - Cowboy AI"
        </div>
    }
}

#[component]
fn HamburgerMenu(children: Children) -> impl IntoView {
    view! {
        <div class="menu hamburger">
            <nav>
                <ul>
                    {children()}
                </ul>
            </nav>
        </div>
    }
}

#[component]
fn Header() -> impl IntoView {
    view! {
        <header>
            <Logo/>
            <Masthead/>
            <HamburgerMenu>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-home"></i>
                        "home"
                    </a>
                </li>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-rocket"></i>
                        "about"
                    </a>
                </li>
                <li>
                    <a href="/">
                        <i class="fa-solid fa-envelope"></i>
                        "contact"
                    </a>
                </li>
            </HamburgerMenu>
        </header>
    }
}

#[component]
fn Logo() -> impl IntoView {
    view! {
        <div id="logo" class="logo">
            <img src="/logo.svg" />
        </div>
    }
}

#[component]
fn Foo() -> impl IntoView {
    view! {
        <div class="foo">
            "foo"
        </div>
    }
}

#[component]
fn TextIn() -> impl IntoView {
    view! {
        <div class="typing">
            <input type="text" placeholder="Discover something" value="Go" />
            <button>
                <i class="fa-solid fa-circle-up"/>
            </button>
        </div>
    }
}
