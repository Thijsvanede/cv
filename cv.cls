%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CV 
%
% Copyright (C) 2020 by Thijs van Ede
%
% Copying and distribution of this file, with or without modification,
% are permitted in any medium without royalty provided the copyright
% notice and this notice are preserved. This file is offered as-is,
% without any warranty.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create CV class
\ProvidesClass{cv}
% A4 11 pt by default
\LoadClass[11pt,a4paper]{article}

% Use bibliography
\usepackage[backend=biber,style=authoryear,sorting=ydnt]{biblatex}
% Suppress page numbers
\pagestyle{empty}
% Set margins
\usepackage[left=0.75in,top=0.6in,right=0.75in,bottom=0.6in]{geometry}
% Use for links
\usepackage[colorlinks]{hyperref}
% Use fonts
\usepackage{fontawesome}
% Remove paragraph indentation
\usepackage[parfill]{parskip}
% Required for table formatting
\usepackage{placeins}
% Format table cells
\usepackage{makecell}
% Required for tables
\usepackage{tabularx}
% Use different colors
\usepackage[dvipsnames]{xcolor}
% Replace strings
\usepackage{xstring}

% Define link
\newcommand{\link}[2]{\href{#1}{\color{Maroon}#2}}

%-------------------------------------------------------------------------------
%	SET WHITESPACE
%-------------------------------------------------------------------------------
\def \namesize        {\huge}      % Size of the name at the top of the document
\def \subtitlesize    {\Large}      % Size of the name at the top of the document
\def \addressskip     {\smallskip} % The space between the two address (or phone/email) lines
\def \sectionlineskip {\medskip}   % The space above the horizontal line for each section 
\def \nameskip        {\bigskip}   % The space after your name at the top
\def \sectionskip     {\bigskip}   % The space after the heading section
\setlength\tabcolsep{0pt}

%-------------------------------------------------------------------------------
%	CONTACT INFO
%-------------------------------------------------------------------------------

% Define name - empty by default
\def \@name {}
\def \name #1 {\def \@name {#1}}
\let \@subtitle \relax
\def \subtitle #1 {\def \@subtitle {#1}}

% Define conact information
\let \@address      \relax
\let \@zipcode      \relax
\let \@city         \relax
\let \@country      \relax
\def \address      #1 {\def \@address      {#1}}
\def \zipcode      #1 {\def \@zipcode      {#1}}
\def \cityname     #1 {\def \@cityname     {#1}}
\def \country      #1 {\def \@country      {#1}}

% Define organization
\let \@organization \relax
\let \@department   \relax
\let \@room         \relax
\def \organization #1 {\def \@organization {#1}}
\def \department   #1 {\def \@department   {#1}}
\def \room         #1 {\def \@room         {#1}}

% Define socials
\let \@email    \relax
\let \@github   \relax
\let \@linkedin \relax
\let \@scholar  \relax
\let \@website  \relax
\def \email    #1 {\def \@email    {#1}}
\def \github   #1 {\def \@github   {#1}}
\def \linkedin #1 {\def \@linkedin {#1}}
\def \scholar  #1 {\def \@scholar  {#1}}
\def \website  #1 {\def \@website  {#1}}

%-------------------------------------------------------------------------------
%	PRINT NAME AS HEADER
%-------------------------------------------------------------------------------

\let\ori@document=\document
\renewcommand{\document}{
	\ori@document  % Begin document
	\begingroup
	\hfil{\MakeUppercase{\namesize\bf \@name}}\hfil
	\nameskip\break
	\endgroup
	
	\begingroup
	\vspace{-1cm}
	\hfil{\@ifundefined{@subtitle}{}{\subtitlesize \@subtitle\\}}\hfil
	\nameskip\break
	\endgroup
	
	\vspace{-1.5cm} % Print the name specified with \name
}

%-------------------------------------------------------------------------------
%	SECTION FORMATTING
%-------------------------------------------------------------------------------

% Section in the CV
\renewcommand{\section}[1]{
	\FloatBarrier
	\sectionskip
	\MakeUppercase{\textbf{#1}} % Section title
	\sectionlineskip
	\hrule % Horizontal line
}

%-------------------------------------------------------------------------------
%	CONTACT FORMATTING
%-------------------------------------------------------------------------------
\newcommand{\contact}{
	
	\section{Contact}
	\vspace{-.25cm}
	\begin{table}[!h]
		\begin{tabularx}{\textwidth}{X r}
			% Address column
			\makecell[cl]{
				\@ifundefined{@organization}{}{\@organization\\}
				\@ifundefined{@department}  {}{\@department\\}
				\@ifundefined{@room}        {}{\@room\\}
				\@ifundefined{@address}     {}{\@address\\}
				\@ifundefined{@zipcode}     {}{\@zipcode\@ifundefined{@cityname}{\\}{,}}
				\@ifundefined{@cityname}    {}{\@cityname\\}
				\@ifundefined{@country}     {}{\@country\\}
			}
		
			&
			
			% Socials column
			\makecell[cr]{
				% Print email if given
				\@ifundefined{@email}{}{
					\link{mailto:\@email}{\@email} {\faEnvelope \hspace*{-.05cm}}\\}
				% Print scholar if given
				\@ifundefined{@scholar}{}{
					\link{\@scholar}{\@name} {\hspace*{-.05cm}\faGraduationCap \hspace*{-.1cm}}\\}
				% Print linkedin if given
				\@ifundefined{@linkedin}{}{
					\link{https://linkedin.com\@linkedin}{\@linkedin} \faLinkedin\\}
				% Print github if given
				\@ifundefined{@github}{}{
					\link{https://github.com/\@github}{\@github} \faGithub\\}
				% Print website if given
				\@ifundefined{@website}{}{
					\link{\@website}{\@website} \faGlobe\\}	
			}
		\end{tabularx}
	\end{table}
	\vspace{-.25cm}
}

%-------------------------------------------------------------------------------
%	SECTION ITEMS FORMATTING
%-------------------------------------------------------------------------------

\newcommand{\cvitem}[4]{
	\begin{table}[!h]
		\begin{tabularx}{\textwidth}{p{1.75cm} X}
			#1 & \hspace{12pt} \textbf{#3} \hfill \emph{#2}\\
			   & \hspace{12pt} \makecell[cl]{#4}
		\end{tabularx}
	\end{table}
}

\newcommand{\cvitemshort}[3]{
	\vspace{-.2cm}
	\begin{table}[!h]
		\begin{tabularx}{\textwidth}{p{1.75cm} X}
			#1 & \hspace{12pt} \makecell[tl]{#3} \hfill \emph{#2}\\
		\end{tabularx}
	\end{table}
	\vspace{-.2cm}
}

\newcommand{\reference}[3]{
	\vspace{-.2cm}
	\begin{table}[!h]
		\begin{tabularx}{\textwidth}{p{4cm} X}
			\textbf{#1} & \hspace{12pt} #3 \hfill \emph{#2}\\
		\end{tabularx}
	\end{table}
	\vspace{-.2cm}
}