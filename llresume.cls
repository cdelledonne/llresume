%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% llresume.cls
%
% Description: Lean LaTeX resume class
% Maintainer:  Carlo Delle Donne <https://github.com/cdelledonne>
% Version:     0.2.1
% License:     MIT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{llresume}[2022/10/05 v0.2.1 Lean LaTeX resume class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Class options and base class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{etoolbox}

\newbool{@llresume@opt@compact}
\setbool{@llresume@opt@compact}{false}
\DeclareOption{compact}{\setbool{@llresume@opt@compact}{true}}

% Process class options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions*

% Load base class
\LoadClass{scrartcl}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[fixed]{fontawesome5}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage[colaction]{multicol}
\RequirePackage{setspace}
\RequirePackage{tcolorbox}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage{xparse}

% Must load after multicol and tikz
\RequirePackage{multicolrule}

\tcbuselibrary{xparse}

\ifpdftex
% For encoding in pdfLaTeX
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dimensions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NewDocumentCommand{\@llresume@setlength}{m m m}{
    \ifbool{@llresume@opt@compact}{\setlength{#1}{#2}}{\setlength{#1}{#3}}
}

% Page margins
\newlength{\lmargin}
\setlength{\lmargin}{1cm}
\newlength{\rmargin}
\setlength{\rmargin}{1cm}
\newlength{\tmargin}
\setlength{\tmargin}{1.2cm}
\newlength{\bmargin}
\setlength{\bmargin}{1.2cm}

% Margin of layout panes
\newlength{\panemargin}
\@llresume@setlength{\panemargin}{0.5cm}{0.75cm}

% Inward margin of layout column
\newlength{\columnmargin}
\setlength{\columnmargin}{0.75cm}

% Internal padding of colored box
\newlength{\boxpadding}
\setlength{\boxpadding}{0.5cm}

% Size of title photo
\newlength{\photosize}
\setlength{\photosize}{2cm}

% Vertical margin before and after main pane's section component
\newlength{\mainsectionmargin}
\@llresume@setlength{\mainsectionmargin}{2.5ex}{3ex}

% Top margin of main pane's entry component
\newlength{\mainentrymargin}
\@llresume@setlength{\mainentrymargin}{1.5ex}{2.5ex}

% Vertical margin between entry title and description and info
\newlength{\mainentrycomponentsmargin}
\@llresume@setlength{\mainentrycomponentsmargin}{0ex}{0.5ex}

% Vertical margin between name of skill groups and skills
\newlength{\skillgroupmargin}
\setlength{\skillgroupmargin}{0.5ex}

% Width of information icon's container box
\newlength{\infoiconboxwidth}
\setlength{\infoiconboxwidth}{0.875em}

% Width of skill icon's container box
\newlength{\skilliconboxwidth}
\setlength{\skilliconboxwidth}{0.875em}

% Horizontal margin of information icon
\newlength{\infoiconmargin}
\setlength{\infoiconmargin}{0.5em}

% Size of lines and arcs of section title and tag boxes
\newlength{\boxlinewidth}
\setlength{\boxlinewidth}{1pt}
\newlength{\boxarc}
\setlength{\boxarc}{1.625ex}

% Padding of section title boxes
\newlength{\secboxhpadding}
\setlength{\secboxhpadding}{1ex}
\newlength{\secboxvpadding}
\setlength{\secboxvpadding}{0.75ex}

% Padding of tag boxes
\newlength{\tagboxhpadding}
\setlength{\tagboxhpadding}{1ex}
\newlength{\tagboxvpadding}
\setlength{\tagboxvpadding}{0.5ex}

% Width of graphic lines
\newlength{\graphiclinewidth}
\setlength{\graphiclinewidth}{2pt}

% Remove paragraph indentation
\setlength{\parindent}{0em}

% Define lengths for multicols environment
\setlength{\columnsep}{2\columnmargin}
\setlength{\multicolsep}{0cm}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Document options and variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\geometry{
    left=\lmargin,
    right=\rmargin,
    top=\tmargin,
    bottom=\bmargin,
    bindingoffset=0em,
    nomarginpar,
    noheadfoot,
}

\pagestyle{empty}

\hypersetup{
    hidelinks,
}

% Convenience boolean
\newbool{@llresume@rightalign}
\setbool{@llresume@rightalign}{false}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Font and colors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifbool{@llresume@opt@compact}{
    \RequirePackage[sfdefault,lf]{carlito}
    \def\iconsize{\scriptsize}
    \setstretch{0.9}
}{
    \RequirePackage[sfdefault,lf,scale=1.1]{carlito}
    \def\iconsize{\scriptsize}
    \setstretch{1.0}
}

\definecolor{accentcolor}{HTML}{1E738D}
\definecolor{fillcolor}{HTML}{F9F3DF}
\definecolor{headingcolor}{HTML}{8D281E}
\definecolor{bgcolor}{HTML}{FFFFFF}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Containers for layout components and panes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NewTColorBox[]{@llresume@containerbox}{o o}{
    boxsep=0cm,
    boxrule=0cm,
    sharp corners,
    left=0cm,
    right=0cm,
    top=0cm,
    bottom=0cm,
    frame empty,
    opacityfill=0,
    leftright skip=0cm,
    nobeforeafter,
    IfValueT={#1}{width=#1},
    IfValueT={#2}{equal height group=#2},
}

\NewTColorBox[]{@llresume@coloredbox}{m o o}{
    boxsep=0cm,
    boxrule=0cm,
    sharp corners,
    IfValueTF={#2}{left=\boxpadding}{left=\lmargin},
    IfValueTF={#2}{right=\boxpadding}{right=\rmargin},
    top=\boxpadding,
    bottom=\boxpadding,
    frame empty,
    colback=#1,
    leftright skip=0cm,
    nobeforeafter,
    IfValueT={#2}{width=#2},
    IfValueT={#3}{equal height group=#3},
    IfValueF={#2}{oversize},
}

\NewTColorBox[]{@llresume@sectitlebox}{o}{
    boxsep=0cm,
    boxrule=\boxlinewidth,
    IfValueTF={#1}{sharp corners=west}{sharp corners=east},
    arc is angular,
    arc=\boxarc,
    IfValueTF={#1}{left=\secboxhpadding}{left=\boxarc},
    IfValueTF={#1}{right=\boxarc}{right=\secboxhpadding},
    top=\secboxvpadding,
    bottom=\secboxvpadding,
    hbox,
    equal height group=titleboxgroup,
    nobeforeafter,
    valign=center,
    box align=bottom,
    oversize,
    colframe=headingcolor,
    colback=fillcolor,
}

\NewTColorBox[]{@llresume@tagbox}{}{
    boxsep=0cm,
    boxrule=\boxlinewidth,
    arc=\boxarc,
    left=\tagboxhpadding,
    right=\tagboxhpadding,
    top=\tagboxvpadding,
    bottom=\tagboxvpadding,
    hbox,
    equal height group=tagboxgroup,
    nobeforeafter,
    valign=center,
    box align=center,
    colframe=accentcolor,
    colback=bgcolor,
}

\NewTColorBox[]{@llresume@labelbox}{}{
    boxsep=0cm,
    boxrule=\boxlinewidth,
    arc=6.5pt,
    left=\boxlpadding,
    right=\boxrpadding,
    top=\boxtpadding,
    bottom=\boxbpadding,
    hbox,
    equal height group=labelboxgroup,
    nobeforeafter,
    valign=center,
    box align=center,
    colframe=accentcolor,
    colback=bgcolor,
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Required user definitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NewDocumentCommand{\name}{m m o}{%
    \newcommand{\@llresume@firstname}{#1}
    \newcommand{\@llresume@lastname}{#2}
    \IfValueT{#3}{\newcommand{\@llresume@pronouns}{#3}}
}

\NewDocumentCommand{\photo}{m}{%
    \newcommand{\@llresume@photo}{#1}
}

\NewDocumentCommand{\personalinfo}{+m}{%
    \newcommand{\@llresume@personalinfo}{#1}
}

\NewDocumentCommand{\tagline}{+m}{%
    \newcommand{\@llresume@tagline}{#1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Base components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NewDocumentCommand{\@llresume@baseentry}{o +m}{%
    \vskip\mainentrymargin%
    \IfValueT{#1}{{\bfseries#1}\par}%
    #2%
    \par%
}

\NewDocumentCommand{\@llresume@baseinfo}{+m o}{%
    \mbox{\IfValueTF{#2}{\href{#2}{#1}}{#1}}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NewDocumentEnvironment{mainsection}{m}{%
    \begin{@llresume@containerbox}%
    \vspace{\mainsectionmargin}%
    \docolaction%
        {\setbool{@llresume@rightalign}{true}\raggedleft}%
        {}%
        {\setbool{@llresume@rightalign}{false}\raggedright}%
    \def\@sectitle{{\bfseries\color{headingcolor}\MakeUppercase{#1}\par}}%
    \ifbool{@llresume@rightalign}%
        {\begin{@llresume@sectitlebox}[right]\@sectitle\end{@llresume@sectitlebox}}%
        {\begin{@llresume@sectitlebox}\@sectitle\end{@llresume@sectitlebox}}%
    \par%
}{%
    \vspace{\mainsectionmargin}%
    \end{@llresume@containerbox}%
}

\NewDocumentCommand{\infoGeneric}{m m o}{%
    \def\@infoline{#2}%
    \def\@infomargin{\hspace{\infoiconmargin}}%
    \def\@infoicon{\makebox[\infoiconboxwidth]{\iconsize\color{accentcolor}#1}}%
    \@llresume@baseinfo{%
        \ifbool{@llresume@rightalign}%
            {\@infoline\@infomargin\@infoicon}%
            {\@infoicon\@infomargin\@infoline}%
    }[#3]%
    \par%
}

\NewDocumentCommand{\entryGeneric}{m +o o o o}{%
    \@llresume@baseentry[#1]{%
        \vskip\mainentrycomponentsmargin%
        \IfValueT{#2}{#2\par}%
        \IfValueT{#3}{{\color{accentcolor}#3}\par}%
        \IfValueT{#4}{{\color{accentcolor}#4}\par}%
        \IfValueT{#5}{{\color{accentcolor}#5}\par}%
    }%
}

\NewDocumentCommand{\entryJob}{m +o m m}{%
    \entryGeneric{#1}[#2][\infoPlace{#3}][\infoDate{#4}]%
}

\NewDocumentCommand{\entryPub}{m +o m m m o}{%
    \entryGeneric{#1}[#2][\infoAuthor{#3}][\infoBook{#4}][\infoLink{#5}[#6]]%
}

\NewDocumentCommand{\entrySkills}{o +m}{%
    \@llresume@baseentry[#1]{%
        \vskip\skillgroupmargin%
        #2%
    }%
}

\NewDocumentCommand{\entryTags}{o +m}{%
    \@llresume@baseentry[#1]{%
        % Add some line spacing to make multiple lines of tags look nicer, but
        % add some negative space in the beginning to remove line spacing on the
        % first line of tags
        \setstretch{1.5}%
        \vspace{-1ex}%
        #2%
    }%
}

\NewDocumentCommand{\skill}{m m}{%
    \def\@skillname{#1}%
    \def\@skillmargin{\hspace{\infoiconmargin}}%
    \def\@skilldots{%
        \foreach \i in {1,2,3}{%
            \makebox[\skilliconboxwidth]{%
                \raisebox{0.125ex}{%
                    \iconsize%
                    \color{accentcolor}%
                    \ifnumgreater{\i}{#2}{\faCircle[regular]}{\faCircle}%
                }%
            }%
        }%
    }%
    \@llresume@baseinfo{%
        \parbox[t]{\dimexpr 0.495\linewidth}{%
            \ifbool{@llresume@rightalign}%
                {\raggedleft\@skillname\@skillmargin\@skilldots}%
                {\raggedright\@skilldots\@skillmargin\@skillname}%
        }%
    }%
}

\NewDocumentCommand{\simpleskill}{o m}{%
    \@llresume@baseinfo{%
        \makebox[\infoiconboxwidth]{%
            \iconsize%
            \color{accentcolor}%
            \IfValueTF{#1}{#1}{\faDotCircle}%
        }%
        ~#2%
        \enspace%
    }%
}

\NewDocumentCommand{\boxedtag}{o m}{%
    \@llresume@baseinfo{%
        \begin{@llresume@tagbox}%
            \makebox[\infoiconboxwidth]{%
                \iconsize%
                \color{accentcolor}%
                \IfValueTF{#1}{#1}{\faTag}%
            }%
            ~#2%
        \end{@llresume@tagbox}%
    }%
}

\NewDocumentCommand{\boxedlabel}{m}{%
    \@llresume@baseinfo{%
        \begin{@llresume@labelbox}%
            {\footnotesize\color{accentcolor}#1}%
        \end{@llresume@labelbox}%
    }%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Info shortcuts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NewDocumentCommand{\infoAddress}{m o}{\infoGeneric{\faHome}{#1}[#2]}
\NewDocumentCommand{\infoAuthor}{m o}{\infoGeneric{\faUser}{#1}[#2]}
\NewDocumentCommand{\infoBirthday}{m o}{\infoGeneric{\faBirthdayCake}{#1}[#2]}
\NewDocumentCommand{\infoBook}{m o}{\infoGeneric{\faBook}{#1}[#2]}
\NewDocumentCommand{\infoDate}{m o}{\infoGeneric{\faCalendarDay}{#1}[#2]}
\NewDocumentCommand{\infoEmail}{m o}{\infoGeneric{\faEnvelope}{#1}[#2]}
\NewDocumentCommand{\infoFlickr}{m o}{\infoGeneric{\faFlickr}{#1}[#2]}
\NewDocumentCommand{\infoGithub}{m o}{\infoGeneric{\faGithub}{#1}[#2]}
\NewDocumentCommand{\infoHomepage}{m o}{\infoGeneric{\faGlobe}{#1}[#2]}
\NewDocumentCommand{\infoInstagram}{m o}{\infoGeneric{\faInstagram}{#1}[#2]}
\NewDocumentCommand{\infoLinkedin}{m o}{\infoGeneric{\faLinkedin}{#1}[#2]}
\NewDocumentCommand{\infoLink}{m o}{\infoGeneric{\faLink}{#1}[#2]}
\NewDocumentCommand{\infoPhone}{m o}{\infoGeneric{\faPhone*}{#1}[#2]}
\NewDocumentCommand{\infoPlace}{m o}{\infoGeneric{\faMapMarker*}{#1}[#2]}
\NewDocumentCommand{\infoTools}{m o}{\infoGeneric{\faTools}{#1}[#2]}
\NewDocumentCommand{\infoYoutube}{m o}{\infoGeneric{\faYoutube}{#1}[#2]}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Header and document end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AfterPreamble{%
    \def\@photoinnersize{\dimexpr \photosize-2\graphiclinewidth}%
    \def\@columnwidth{\dimexpr 0.5\linewidth-\columnmargin}%
    \def\@photocomponent{%
        \raggedright%
        \begin{tikzpicture}[baseline=(current bounding box.north)]%
            \node[
                draw,
                circle,
                minimum size=\photosize,
                line width=\graphiclinewidth,
                accentcolor,
            ] {};
            \node[
                draw,
                circle,
                minimum size=\@photoinnersize,
                line width=\graphiclinewidth,
                bgcolor,
                path picture={
                    \node at (path picture bounding box.center){
                        \includegraphics[width=\@photoinnersize]{\@llresume@photo}
                    };
                }
            ] {};
        \end{tikzpicture}%
    }%
    \def\@namecomponent{%
        \setstretch{1.375}%
        \raggedright%
        \color{headingcolor}%
        {\LARGE\bfseries\@llresume@firstname}%
        \par%
        {\LARGE\bfseries\MakeUppercase{\@llresume@lastname}}%
        \ifdefined\@llresume@pronouns%
        \par%
        {\Large(\@llresume@pronouns)}%
        \fi%
    }%
    \def\@personalinfocomponent{%
        \raggedright%
        \setbool{@llresume@rightalign}{false}%
        \@llresume@personalinfo%
    }%
    \begin{@llresume@containerbox}[\@columnwidth][headergroup]%
        \def\@photoboxwidth{\dimexpr \photosize+\columnmargin}%
        \def\@nameboxwidth{\dimexpr \linewidth-\photosize-\columnmargin}%
        \begin{@llresume@containerbox}[\@photoboxwidth][photogroup]%
            \@photocomponent%
        \end{@llresume@containerbox}%
        \begin{@llresume@containerbox}[\@nameboxwidth][photogroup]%
            \@namecomponent%
        \end{@llresume@containerbox}%
    \end{@llresume@containerbox}%
    \hfill%
    \begin{@llresume@containerbox}[\@columnwidth][headergroup]%
        \@personalinfocomponent%
    \end{@llresume@containerbox}%
    \par%
    \vskip\panemargin%
    \begin{@llresume@coloredbox}{fillcolor}%
        \raggedright%
        \@llresume@tagline%
    \end{@llresume@coloredbox}%
}

\AfterPreamble{%
    \vskip\panemargin%
    \begin{multicols}{2}
        % Column separator
        \SetMCRule{
            color=accentcolor,
            line-style=solid-circles,
            width=\graphiclinewidth,
        }
        % Do not fill up vertical space
        \raggedcolumns%
}

\AtEndDocument{%
    \end{multicols}
}
