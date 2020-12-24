Describe "dupcheck.sh"
  Describe "Duplication Check"
    It 'must be Succeed'
      When run script ./dupcheck.sh spec/dupcheck/success_01.yml
      The line 1 of output should eq '[ OK ] No Duplicate lines.'
      The status should be success
    End

    It 'must be Failed because duplicated line existed'
      When run script ./dupcheck.sh spec/dupcheck/failed_01.yml
      The line 1 of output should eq '[ NG ] Duplicate Line(s) found.'
      The status should eq 1
    End

    It 'must be Failed because no file specified'
      When run script ./dupcheck.sh 
      The line 1 of output should eq 'Usage ./dupcheck.sh <files>'
      The status should eq 2
    End

    It 'must be Failed because duplicated line existed in 2 files'
      When run script ./dupcheck.sh spec/dupcheck/success_01.yml spec/dupcheck/failed_01.yml
      The line 1 of output should eq '[ NG ] Duplicate Line(s) found.'
      The status should eq 1
    End

  End
End
