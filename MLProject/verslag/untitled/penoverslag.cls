%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                    %%%
%%%   Class bestand voor het verslag van P&O: Computerwetenschappen.   %%%
%%%                                                                    %%%
%%%   Opties:                                                          %%%
%%%     tt      Tussentijdsverslag                                     %%%
%%%     eind    Eindverslag                                            %%%
%%%                                                                    %%%
%%%   2 december 2013                                                  %%%
%%%   Versie 1.2                                                       %%%
%%%                                                                    %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{penoverslag}[2012/09/25 v1.0 P&O verslag document class]
\def\thetitle{}
\def\thepagelimit{100}
\DeclareOption{tt}{%
  \def\thetitle{Tussentijdsverslag}%
  \def\thepagelimit{100}}
\DeclareOption{eind}{%
  \def\thetitle{Who has my phone?}%
  \def\thepagelimit{100}}
\ProcessOptions
\LoadClass[10pt,a4paper]{article}
\RequirePackage[utf8]{inputenc}
\RequirePackage[colorlinks,linkcolor=black,citecolor=black,urlcolor=black]{hyperref}
\RequirePackage{url}
\RequirePackage{color}
\RequirePackage{everypage}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\geometry{margin=3cm}
\def\team#1{\def\theteam{#1}}
\def\members#1{\def\themembers{#1}}
\def\maketitlepage{%
  \begin{titlepage}%
    \begin{center}%
      \@makelogo%
      \vfill%
      {\Huge\sc Machine Learning}\\[0.75cm]%
      {\huge\bf \thetitle}%
      \vfill%
      \begin{minipage}{0.2\textwidth}%
        \begin{flushleft}%
          {\Large\em Group:} \\[6pt]%
          {\LARGE\bf \theteam}%
        \end{flushleft}%
      \end{minipage}\hfill%
      \begin{minipage}{0.75\textwidth}%
        \begin{flushright}%
          {\Large\sc \themembers\\}%
        \end{flushright}%
      \end{minipage}\\%
      \vspace{20mm}%
      {\large Academiejaar 2014 -- 2015}%
    \end{center}%
  \end{titlepage}%
}
\def\@makelogo{%
  \hfil%
  \begin{minipage}{0.2\textwidth}%
    \centering%
    \includegraphics[height=\sedes@height]{sedes}%
  \end{minipage}%
  \begin{minipage}{0.7\textwidth}%
    {\huge\sf KU~Leuven}\\[10pt]%
    {\LARGE\sf Departement of Computer Science}%
  \end{minipage}%
  \hfil%
}
\def\sedes@height{3.4cm}
\def\pagelimittext{PAGE LIMIT}
\def\pagelimitfontsize{2cm}
\def\pagelimitscale{5}
\newcommand\sc@wm@inbox[1]{%
  \setbox\@tempboxa\vbox to \z@{%
    \vskip -1in \moveleft 1in \vbox{%
      \hbox to \z@{%
        #1\hss}%
    }%
    \vss%
  }
  \dp\@tempboxa\z@
  \box\@tempboxa%
}
\newcommand\sc@wm@printtext[1]{%
  \setlength{\@tempdimb}{.5\paperwidth}%
  \setlength{\@tempdimc}{-.5\paperheight}%
  \setlength{\unitlength}{1pt}%
  \put(\strip@pt\@tempdimb,\strip@pt\@tempdimc){%
    \makebox(0,0){%
      \rotatebox{45}{\scalebox{\pagelimitscale}{%
        \textcolor[gray]{0.7}%
          {\fontsize{\pagelimitfontsize}{1.2\pagelimitfontsize}\selectfont{\pagelimittext}}%
      }}%
    }%
  }%
}
\AddEverypageHook{%
  \ifnum\thepage>\thepagelimit%
    \sc@wm@inbox{\sc@wm@printtext}
  \fi
}
\def\makeappendix{%
  \appendix%
  \addtocontents{toc}{\protect\setcounter{tocdepth}{1}}%
}
\endinput