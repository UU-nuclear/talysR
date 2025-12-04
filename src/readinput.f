      subroutine readinput
c
c +---------------------------------------------------------------------
c | Author: Arjan Koning
c | Date  : January 20, 2023
c | Task  : Read input
c +---------------------------------------------------------------------
c
c +---------------------------------------------------------------------
c | Modified by: Alf Göök
c | Date       : January 10, 2023
c | Purpuse    : read from file 'input' instead of stdin in order to
c |              make it work with MPI
c +---------------------------------------------------------------------
c
c ****************** Declarations and common blocks ********************
c
      include "talys.cmb"
      integer i,istat
c
c ************************** User Input ********************************
c
c iso     : counter for isotope
c inline  : input line
c numlines: maximum number of input lines
c nlines  : number of input lines
c
c modification: instead of reading from stdin we read from a file in the
c current directory called 'input'
      open(1, file = 'input', status = 'old')
c
c
c We read the complete input file first as a set of character strings.
c The actual keywords will be read from these later on. For natural
c elements, the input file only needs to be read once.
c
      if (iso /= 1) return
      if (nlines > 0) return
      i = 1
      do
        read(1, '(a132)', iostat = istat) inline(i)
        if (istat ==  -1) exit
        i = i + 1
        if (i > numlines) then
          write(*,'(" TALYS-error: Number of input lines exceeds ",i5)')
     +      numlines
          write(*,'(" numlines in talys.cmb should be increased")')
          stop
        endif
      enddo
      nlines = i - 1

      close(1)
c
c ************** Convert uppercase to lowercase characters *************
c
c For easy handling of all the input parameters, the whole input is
c converted to lowercase characters, with the exception of filenames or
c other character strings.
c
c convert: subroutine to convert input line from upper case to lowercase
c
      do i=1,nlines
        call convert(i)
      enddo
      nlines0=nlines
      return
      end
Copyright (C)  2023 A.J. Koning, S. Hilaire and S. Goriely
