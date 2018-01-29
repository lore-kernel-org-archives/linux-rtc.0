Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:58588 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751032AbeA2CtM (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 28 Jan 2018 21:49:12 -0500
From: Zhang Rui <rui.zhang@intel.com>
To: alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org
Cc: gabriele.mzt@gmail.com, rui.zhang@intel.com, x86@kernel.org,
        tglx@linutronix.de
Subject: [PATCH 1/4] X86: check X86_VENDOR_ANY correctly
Date: Mon, 29 Jan 2018 10:48:45 +0800
Message-Id: <1517194128-5326-1-git-send-email-rui.zhang@intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

static const struct x86_cpu_id foo[] = {
	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_ANY },
	{}
};

x86_match_cpu(foo) returns NULL with Intel processors.

This is wrong because,
unlike X86_FAMILY_ANY/X86_MODEL_ANY/X86_FEATURE_ANY, X86_VENDOR_ANY is
0xffff, rather than 0.

Fix x86_match_cpu() by checking X86_VENDOR_ANY explicitly.

cc: x86@kernel.org
cc: tglx@linutronix.de
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/cpu/match.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 3fed388..72f363e 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -34,7 +34,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 	const struct x86_cpu_id *m;
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
-	for (m = match; m->vendor | m->family | m->model | m->feature; m++) {
+	for (m = match; (m->vendor != X86_VENDOR_ANY) | m->family | m->model | m->feature; m++) {
 		if (m->vendor != X86_VENDOR_ANY && c->x86_vendor != m->vendor)
 			continue;
 		if (m->family != X86_FAMILY_ANY && c->x86 != m->family)
-- 
2.7.4
