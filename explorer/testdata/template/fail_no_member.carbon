// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// RUN: %{not} %{explorer-run}
// RUN: %{not} %{explorer-run-trace}

package ExplorerTest api;

interface GetX {
  fn DoIt[self: Self]() -> i32;
}

impl forall [template T:! type] T as GetX {
  // CHECK:STDERR: COMPILATION ERROR: {{.*}}/explorer/testdata/template/fail_no_member.carbon:[[@LINE+1]]: member access into unexpected type `i32` in `self.x`
  fn DoIt[self: Self]() -> i32 { return self.x; }
}

fn Main() -> i32 {
  // CHECK:STDERR: NOTE: {{.*}}/explorer/testdata/template/fail_no_member.carbon:[[@LINE+1]]: in instantiation of `impl T as GetX` with `T = i32` required here
  return 0.(GetX.DoIt)();
}
