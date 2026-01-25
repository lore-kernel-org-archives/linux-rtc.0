Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E10E2F362D;
	Sun, 25 Jan 2026 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769369245; cv=none; b=odC5eyfi+/wCKSl8FiodbxfdjKODnKgZPZAfj3GSwzDefgZu4Y6LWvB+keAdNazpsKTOr7ByOse57F2Yu/rqm65k48ipR5MHCyCgBHzy6zLiP8l5Cl7I26D73SVL2i1SaixN0jyKjEnjlymRAu1s03pIX8lMTLLV9pLVvI6TRTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769369245; c=relaxed/simple;
	bh=mbmnSdj+CaOK1gm4xD5vso2F981zCQTwCBQJWRt8vZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxBndkKixtdfelipVTQY2eaT7zsuw7Nf+aYnlXKMO7br0Om/p+IPpQYolInZthxukAM+FQD07R6+9B2RpkOYe0c9Y9OzPlkN08CrH0DCWOl1w079LD7qEnrk4zYo5sh8Cl8dHNZqgLd8rtHnho4/ROB4E+GGapsD+J5m0JXUmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: GN5hXFtHRD2VxA4s6y/aVQ==
X-CSE-MsgGUID: xAnKMIeKScmqYVojljW+mg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Jan 2026 04:27:22 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.19])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D0D7C4035223;
	Mon, 26 Jan 2026 04:27:17 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: claudiu.beznea.uj@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 2/5] clk: renesas: r9a09g056: Add clock and reset entries for RTC
Date: Sun, 25 Jan 2026 19:27:02 +0000
Message-ID: <20260125192706.27099-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125192706.27099-1-ovidiu.panait.rb@renesas.com>
References: <20260125192706.27099-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add module clock and reset entries for the RTC module on the Renesas RZ/V2N
(R9A09G056) SoC.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/clk/renesas/r9a09g056-cpg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g056-cpg.c b/drivers/clk/renesas/r9a09g056-cpg.c
index 70de6bb929b9..549c882f9a18 100644
--- a/drivers/clk/renesas/r9a09g056-cpg.c
+++ b/drivers/clk/renesas/r9a09g056-cpg.c
@@ -289,6 +289,8 @@ static const struct rzv2h_mod_clk r9a09g056_mod_clks[] __initconst = {
 						BUS_MSTOP(5, BIT(13))),
 	DEF_MOD("wdt_3_clk_loco",		CLK_QEXTAL, 5, 2, 2, 18,
 						BUS_MSTOP(5, BIT(13))),
+	DEF_MOD("rtc_0_clk_rtc",		CLK_PLLCM33_DIV16, 5, 3, 2, 19,
+						BUS_MSTOP(3, BIT(11) | BIT(12))),
 	DEF_MOD("rspi_0_pclk",			CLK_PLLCLN_DIV8, 5, 4, 2, 20,
 						BUS_MSTOP(11, BIT(0))),
 	DEF_MOD("rspi_0_pclk_sfr",		CLK_PLLCLN_DIV8, 5, 5, 2, 21,
@@ -593,6 +595,8 @@ static const struct rzv2h_reset r9a09g056_resets[] __initconst = {
 	DEF_RST(9, 2, 4, 3),		/* RSCI8_TRESETN */
 	DEF_RST(9, 3, 4, 4),		/* RSCI9_PRESETN */
 	DEF_RST(9, 4, 4, 5),		/* RSCI9_TRESETN */
+	DEF_RST(7, 9, 3, 10),		/* RTC_0_RST_RTC */
+	DEF_RST(7, 10, 3, 11),		/* RTC_0_RST_RTC_V */
 	DEF_RST(7, 11, 3, 12),		/* RSPI_0_PRESETN */
 	DEF_RST(7, 12, 3, 13),		/* RSPI_0_TRESETN */
 	DEF_RST(7, 13, 3, 14),		/* RSPI_1_PRESETN */
-- 
2.51.0

