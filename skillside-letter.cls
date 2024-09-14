%% start of file `skillside-letter.cls'.
%% Copyright 2024 Malte Nilges.
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License version 1.3c,
% available at http://www.latex-project.org/lppl/. 

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{skillside-letter}[2024/09/01 v1.0 skillside letter]
%-------------------------------------------------------------------------------
%                class options
%
% (need to be done before the external package loading, for example because
% we need \paperwidth, \paperheight and \@ptsize to be defined before loading
% geometry and fancyhdr)
%-------------------------------------------------------------------------------
\RequirePackage{xkeyval}
\newcommand\letterlanguage{english}
\DeclareOptionX{language}[english]{\renewcommand\letterlanguage{#1}}
\ProcessOptionsX

% paper size option
\DeclareOption{a4paper}{
  \setlength\paperheight{297mm}
  \setlength\paperwidth{210mm}}

% font size options
\newcommand\@ptsize{}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}

% font type options
\DeclareOption{sans}{\AtBeginDocument{\renewcommand{\familydefault}{\sfdefault}}}
\DeclareOption{roman}{\AtBeginDocument{\renewcommand{\familydefault}{\rmdefault}}}
% \DeclareOption{times}{\AtBeginDocument{\usepackage{times}\fontfamily{ptm}\selectfont}}
\DeclareOption{overpass}{\AtBeginDocument{
    \defaultfontfeatures{RawFeature={+axis={wght=400}}}
    \setmainfont{Overpass-VariableFont_wght}[
    Path = fonts/,
    Extension = .ttf,
    ItalicFont=Overpass-Italic-VariableFont_wght,
    BoldFont=Overpass-VariableFont_wght,
    BoldFeatures={RawFeature={+axis={wght=600}}},
    BoldItalicFeatures={RawFeature={+axis={wght=600}}}
    ]}}
% \DeclareOption{times}{\AtBeginDocument{\setmainfont{Overpass-Regular.ttf}}}

  
% execute default options
\ExecuteOptions{a4paper,11pt,final}

% process given options
\ProcessOptions\relax
\input{size1\@ptsize.clo}

\usepackage[margin=.5in]{geometry}

%-------------------------------------------------------------------------------
%                Packages
%-------------------------------------------------------------------------------
\RequirePackage[hidelinks, pdfpagelabels=false]{hyperref}           % Clickable links
% \hypersetup{hidelinks, pdfpagelabels=false}
\RequirePackage[T1]{fontenc}
\RequirePackage{graphicx}           % Picture
\RequirePackage{geometry}           % to adjust margins
\RequirePackage{fontawesome}        % symbols (phone, e-mail, etc.)
\RequirePackage{xcolor}             % colours
\RequirePackage[most]{tcolorbox}
\RequirePackage{dashrule}           % Dotted line
\RequirePackage{adjustbox}
\RequirePackage{fancyhdr}
\RequirePackage[shortcuts]{extdash}

% colorbar
\RequirePackage{paracol}
\RequirePackage{lipsum}
\RequirePackage{eso-pic}

% loads a style/color scheme
\newcommand*{\addstyle}[1]{
  \RequirePackage{skillside-letter-#1}}

%-------------------------------------------------------------------------------
%                Color and font options
%
%-------------------------------------------------------------------------------
\definecolor{color0}{rgb}{0,0,0}            % black
\definecolor{color1}{rgb}{1,1,1}            % white
\definecolor{color2}{rgb}{0.45,0.45,0.45}   % dark grey
\definecolor{color3}{rgb}{0.6,0.6,0.6}      % light grey
\definecolor{color4}{rgb}{1,1,1}            % white

% Soft text:
\newcommand{\softtext}[1]{\color{color3}{#1}}
\newcommand{\softbullet}{\softtext{\small\textbullet}\hspace{0.5em}}
\newcommand{\veritem}[1]{\softbullet#1\hspace{1em}}
%\renewcommand{\labelitemi}{\softtext{\small\textbullet}}


% font loading
\usepackage{ifxetex,ifluatex}
\newif\ifxetexorluatex
\ifxetex
 \xetexorluatextrue
\else
 \ifluatex
   \xetexorluatextrue
 \else
   \xetexorluatexfalse
 \fi
\fi
% automatic loading of latin modern fonts
\ifxetexorluatex
 \RequirePackage{fontspec}
 \defaultfontfeatures{Ligatures=TeX}
 \RequirePackage{unicode-math}
 % \setmainfont{bahnschrift.ttf}
 % \setsansfont{Latin Modern Sans}
 % \setmathfont{Latin Modern Math}
\else
  \RequirePackage[T1]{fontenc}
  \IfFileExists{lmodern.sty}%
    {\RequirePackage{lmodern}}%
    {}
\fi


%-------------------------------------------------------------------------------
%                Document adjustments
%
%-------------------------------------------------------------------------------
\geometry{%
        left=23mm,
        right=23mm, 
        bindingoffset=0mm, 
        top=20mm,
        bottom=20mm
    }
%
\newcommand{\linia}{\rule{\linewidth}{0.5pt}}
\newcommand{\dotline}{\noindent\textcolor{soft_text}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\medskip}


% custom footers and headers
\setcounter{secnumdepth}{0}
% \setlength{\parskip}{2\baselineskip plus2pt}
\setlength{\parskip}{\baselineskip}
\setlength{\parindent}{0pt}
\pagestyle{empty}

% \cfoot{Side \thepage\ av\ \pageref*{LastPage}}
% \rfoot{}
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\footrulewidth}{0.5pt}

% UPPER COLOR BAR
% add * for this page only, add a background that fills have the page (from the top)
\AddToShipoutPictureBG*{%
  \AtPageUpperLeft{%
    \raisebox{-.335\paperheight}{%
    %\hspace*{.5\paperwidth}%
    % \color{lightgray}%
    \color{color1}%
    \rule{\paperwidth}{.335\paperheight}%
    }
  }%
}%


%-------------------------------------------------------------------------------
%                New commands
%
%-------------------------------------------------------------------------------
\def\Plus{\texttt{+}}

% Date commands
\newcommand\ProvideDate[1]{%
  \expandafter\newcommand\csname Date\endcsname{%
    #1
  }%
}

% Author Name command
\newcommand\ProvideAuthorName[1]{%
  \expandafter\newcommand\csname AuthorName\endcsname{%
    #1
  }%
}

% Author Address command
\newcommand\ProvideAuthorAddress[2]{%
  \expandafter\newcommand\csname AuthorAddressStreet\endcsname{%
    #1
  }%
  \expandafter\newcommand\csname AuthorAddressCity\endcsname{%
    #2
  }%
}

% e-mail command:
\newcommand\ProvideAuthorEmail[1]{%
  \expandafter\newcommand\csname AuthorEmail\endcsname{%
    \href{mailto:#1}{#1}%
  }%
}

% Author Phone command:
\newcommand\ProvideAuthorPhone[1]{%
  \expandafter\newcommand\csname AuthorPhone\endcsname{%
    #1
  }%
}

% Company Name command
\newcommand\ProvideCompanyName[1]{%
  \expandafter\newcommand\csname CompanyName\endcsname{%
    #1
  }%
}

% Company Correspondent command
\newcommand\ProvideCompanyCorrespondent[1]{%
  \expandafter\newcommand\csname CompanyCorrespondent\endcsname{%
    #1
  }%
}

% Company Adress command
\newcommand\ProvideCompanyAddress[2]{%
  \expandafter\newcommand\csname CompanyAddressStreet\endcsname{%
    #1
  }%
  \expandafter\newcommand\csname CompanyAddressCity\endcsname{%
    #2
  }%
}

% Text command:
\newcommand\ProvideText[1]{%
  \expandafter\newcommand\csname Text\endcsname{%
    #1
  }%
}

% Subject command:
\newcommand\ProvideSubject[1]{%
  \expandafter\newcommand\csname Subject\endcsname{%
    #1
  }%
}

%-------------------------------------------------------------------------------
%                Section
%
%-------------------------------------------------------------------------------
\newcommand{\section}{\@ifstar\@section\@@section}
% Starred section command (\section*{ })
% This is needed to fix bibliography title(s).
\newcommand{\@section}[1]{%
  \bigskip%
  {\LARGE\MakeUppercase{#1}}\\[-1ex]%
  \linia\medskip
}

% Unstarred section command (\section{ })
\newcommand{\@@section}[1]{%
  \bigskip%
  {\LARGE\MakeUppercase{#1}\par} %\\[-1ex]
  % \linia
  \bigskip
}

% Subsection:
\newcommand{\subsection}[1]{%
  \smallskip%
  {\large\bfseries{#1}\par}\medskip
}


%-------------------------------------------------------------------------------
%                Title, Subject and text
%
%-------------------------------------------------------------------------------
\newlength{\thirdofpage}
\setlength{\thirdofpage}{.28\paperheight}
\addtolength{\thirdofpage}{\topmargin}
% \addtolength{\thirdofpage}{-1in}

\renewcommand{\maketitle}{
    \begin{minipage}[t][\thirdofpage][t]{\textwidth}
    \color{color4}
    \noindent
    % \vspace{1ex}
    
    \begin{minipage}{\textwidth}
    % \rule{0.1cm}{\thirdofpage}
        \begin{flushright}
        \AuthorName \\ 
        \AuthorAddressStreet \\ 
        \AuthorAddressCity \\ 
        \AuthorEmail \\ 
        \AuthorPhone
        \end{flushright}
    \end{minipage}
    \begin{minipage}{\textwidth}
        \vspace{2\baselineskip}
        \CompanyName \\ 
        \CompanyCorrespondent \\ 
        \CompanyAddressStreet \\
        \CompanyAddressCity
        \begin{flushright}
        \vspace{-2\baselineskip}
        \Date
        \end{flushright}
    \end{minipage} \hfill
    \end{minipage}
}

\newcommand{\makesubject}{}
\renewcommand{\makesubject}{
  \color{color4}\section{\Subject}\color{color0}
}

\newcommand{\maketext}{}
\renewcommand{\maketext}{
  \Text
}

\newcommand\makesignature[3]{%
  \vspace{\baselineskip}
  #1 \\
  \begin{minipage}{0.6\textwidth}
  \vspace{0.5\baselineskip}
  \includegraphics[#3]{#2}
  \end{minipage} 
  % \\
  \vspace{0.5\baselineskip} \\
  \makeatletter
  \AuthorName
  \makeatother
}

\newcommand{\makesignatureline}[2]{%
  \vspace{\baselineskip}
  #1 \\
  \begin{minipage}{0.6\textwidth}
  \vspace{3\baselineskip}
  \makebox[#2]{\hrulefill}
  \end{minipage} 
  \vspace{\baselineskip} \\
  \makeatletter
  \@author
  \makeatother
}


\endinput

%% end of file `skillside-letter.cls'.