Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612722E3E8;
	Fri,  5 Jan 2024 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.04,334,1695654000"; 
   d="scan'208";a="193347153"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jan 2024 23:53:49 +0900
Received: from localhost.localdomain (unknown [10.226.93.3])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 03C7F430AD66;
	Fri,  5 Jan 2024 23:53:46 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Support Opensource <support.opensource@diasemi.com>,
	linux-rtc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 0/3] Make IRQ as optional
Date: Fri,  5 Jan 2024 14:53:41 +0000
Message-Id: <20240105145344.204453-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some platforms (eg: RZ/{G2UL,Five} SMARC EVK), there is no IRQ
populated by default. Add irq optional support.

v2->v3:
 * Dropped clearing redundant RTC_FEATURE_UPDATE_INTERRUPT bit
 * Added Rb tag from Geert for patch#1.
v1->v2:
 * Make RTC patch series separate from dt patches.
 * Propagated real errors for platform_get_irq_byname_optional().
 * Cleared ALARM feature bit for non-irq case.
 * Added Rb tag from Geert for patch#2 and #3
 * Restored dev_err() for devm_request_threaded_irq() as an RTC can wake
   up a system without an IRQ.

Biju Das (3):
  rtc: da9063: Make IRQ as optional
  rtc: da9063: Use device_get_match_data()
  rtc: da9063: Use dev_err_probe()

 drivers/rtc/rtc-da9063.c | 88 ++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 48 deletions(-)

-- 
2.25.1

