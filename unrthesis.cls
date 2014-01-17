%%
%% File:   unrthesis.cls
%%
%% Use:    Provides a class for structuring a master's thesis or PhD dissertation at the 
%%         University of Nevada, Reno (specifically in the CSE department). This is clearly
%%         not a comprehensive class. It is simply intended as a starting place for 
%%         UNR grad students who are typesetting their thesis/dissertation.
%%
%% Date:   November 13, 2013
%%
%% Author: Alex Fiannaca, fiannac4@live.com, www.alifeincode.com
%%
%% NOTES:  This class is simply an adaptation of the Cornell Thesis class. The template for the
%%         Cornell Thesis class can be downloaded from the templates section of ShareLatex.
%%
%%         *several small changes were made directly to cornell.cls. See the 'base/CHANGES' file
%%         for more information
%%

\ProvidesClass{unrthesis}[2012/11/13 v1.0 Master's thesis document class]
\NeedsTeXFormat{LaTeX2e}[1995/12/01]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{base/cornell}}
\ProcessOptions \relax

\LoadClass{base/cornell}

% Set the outpt style of the bibliography
\bibliographystyle{plain}

% Adjust how floating occurs - this is from the Cornell template originally
\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.75}

% Clean up the way that we declare the appendices so that it is consistent with the 
% rest of the template
\RequirePackage[toc]{appendix}

% Set the margins required by the grad school
\RequirePackage[left=1.5in, right=1.0in, top=1.0in, bottom=1.25in]{geometry}

% Set the page numbering style required by the grad school
\RequirePackage{fancyhdr}
\pagestyle{fancyplain}
\fancyhf{}
\rhead{ \fancyplain{\thepage}{\thepage} }
\renewcommand{\headrulewidth}{0pt} % remove lines as well
\renewcommand{\footrulewidth}{0pt}

% Add some new fields to specialize the title page
\newcommand{\@advisor}{Your Advisor}
\newcommand{\advisor}[1]{\renewcommand{\@advisor}{#1}}
\newcommand{\@masterstype}{Science}
\newcommand{\masterstype}[1]{\renewcommand{\@masterstype}{#1}}

% Adjust the output of the title page...
\renewcommand{\maketitle}{%
  \titlesize{\fontsize{12}{24}\selectfont}%
  \begin{titlepage}%
    \realsinglespacing
    \begin{center}%
      \hrule height 0.5in width 0pt % force vertical space at top
      University of Nevada, Reno
    \end{center}
    \vfill
    \begin{center}%
      \textbf{\@titlesize \expandafter\uppercase\expandafter{\@title}}
    \end{center}
    \vfill
    \begin{center}
      \@subtitlesize
      A \ifphd Dissertation \else Thesis \fi Submitted in Partial Fulfillment \\
      of the Requirements for the Degree of 
      \ifphd Doctor of Philosophy \else Master of \@masterstype \fi ~in \\
      \@degreefield
    \end{center}
    \vfill
    \begin{center}
      \@authorsize
      by \\
      \@author \\
      \@advisor ~/ \ifphd Dissertation \else Thesis \fi Advisor \\
      \@conferralmonth\ \@conferralyear
    \end{center}
  \end{titlepage}
}

% Create list of committee members
\newcommand\addcommitteemember[3]{%
  \write\@auxout{\noexpand\@writefile{members}{#1, #2 -- #3\noexpand\linebreak ~\noexpand\linebreak}}}
\newcommand\addgraduatedean[2]{%
  \write\@auxout{\noexpand\@writefile{members}{#1, #2 -- Dean, Graduate School}}}
\newcommand\listofmembers{%
    \@starttoc{members}%
}
  
% Allow for the creation of the committee approval page
\newenvironment{committeepage}{%
  \typeout{Committee Approval page}
  \pagestyle{empty}
  \doublespacing
}{%
  \normalspacing\clearpage
}

% Larger spacing for the distance between committee member names
\newcommand{\doublespacingplus}{%
  \let\CS=\@currsize\renewcommand{\baselinestretch}{2.5}\CS}
  
% Set the text size for the header of the committee approval page
\newcommand{\@gradheadersize}{\fontsize{16}{24}\selectfont}
\newcommand{\gradheadersize}[1]{\renewcommand{\@gradheadersize}{#1}}

% Create the committee page
\newcommand{\makecommitteepage}{%
    \begin{committeepage}
        \noindent\makebox[0pt][l]{\hspace{-5.0em}\textbf{\@gradheadersize UNIVERSITY}}
        
        \noindent
        \makebox[0pt][l]{\hspace{-5.0em}\textbf{\@gradheadersize OF NEVADA}}%
        \makebox[\textwidth][c]{\textbf{\@gradheadersize THE GRADUATE SCHOOL}}
        
        \noindent\makebox[0pt][l]{\hspace{-5.0em}\textbf{\@gradheadersize RENO}}
        \vfill
        \begin{center}%
            \singlespacing
            We recommend that the thesis prepared \\
            under our supervision by \\
            \normalspacing
        \end{center}
        \vfill
        \begin{center}%
            \textbf{\expandafter\uppercase\expandafter{\@author}} \\
        \end{center}
        \vfill
        \begin{center}%
            entitled
        \end{center}
        \vfill
        \begin{center}%
            \textbf{\expandafter\uppercase\expandafter{\@title}}
        \end{center}
        \vfill
        \begin{center}%
            \singlespacing
            be accepted in partial fulfillment of the \\
            requirements for the degree of \\
            \ifphd DOCTOR OF PHILOSOPHY \else MASTER OF 
            \expandafter\uppercase\expandafter{\@masterstype} \fi
            \normalspacing
        \end{center}
        \vfill
        \begin{center}%
            \doublespacingplus
            \listofmembers
            \normalspacing
        \end{center}
        \vfill
        \begin{center}%
            \@conferralmonth\ \@conferralyear
        \end{center}
    \end{committeepage}
}

% Remove the extra space above "ABSTRACT" which was added in the Cornell class and start 
% roman numerals here
\renewenvironment{abstract}{
  \pagenumbering{roman}
  \prelim@contents{Abstract}
  \chapter*{Abstract}
}{%
  \clearpage
}

% Environment for the main body of the thesis/dissertation
\newenvironment{manuscript}{
    \normalspacing \setcounter{page}{1} \pagenumbering{arabic}
    \addtolength{\parskip}{0.5\baselineskip}
}{
}
\endinput