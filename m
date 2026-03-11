Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13F383C86;
	Wed, 11 Mar 2026 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773259366; cv=none; b=rfBGNsLAlJ6ECz96hGrpDqqUKvRk39MpjAZ0IDaWnzsAN6DvNParFlbpzKgXLjXbiF6K/zbEOGLPlRwbC4tEo9Nvdd0nny4OibqIbBu83JjqFZeyrNckdGBbIAlrLvv76Fll/WiC/6veRAUWIQ0sAENsq0GuNpMTvXojmjt3b8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773259366; c=relaxed/simple;
	bh=zPnjoXw08YMNNV3/AEn/g4Vdd0XKRiOaNUdFYSxNwg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LE2GEe8v/Hx7YKIIHWZ3AgCB6eqywQY5Rqsx6EeqCvXdQqjI7lgXpyRyuzt3NiV07gXAjW+dCkmkz6PRP+CXYwt5ZTPpsn45uEs/Yc2/34ogAIbdkrb0Y7W790MZ+g37/0N9XVkTH1F7ffMp8Z6SXtDji5W/NGD453MwQM9zLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=fail (0-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=s+DqyYLd reason="key not found in DNS"; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="s+DqyYLd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=990Tn+4G4Zbb0Uydm1+sIapSOYaCX24wog9+GqUb5Qc=; b=s+DqyYLdqx/hp0yony+PidpmDj
	xP2yRZqR0RJ7rMU1w6T9lQXD4it2sfPEKNFYTa/TrY+mHhWbRI1r+OhbG0N0chsFQHqxeiswNoG92
	IRqzRkNvA13VFeZiYYLqS6DhvJkWEFlElQIu8gPYPIYpQnnaOfBr3134gpBLyXCEk0D0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1w0PlT-000000000Lu-1Myy;
	Wed, 11 Mar 2026 16:02:43 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hugo@hugovil.com,
	bruno.thomsen@gmail.com,
	giampiero@sferalabs.cc,
	p.rosenberger@kunbus.com,
	antonio@amsobr.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 3/4] rtc: add battery low voltage detection feature
Date: Wed, 11 Mar 2026 16:02:29 -0400
Message-ID: <20260311200237.3531981-4-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311200237.3531981-1-hugo@hugovil.com>
References: <20260311200237.3531981-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Some RTCs have a battery low voltage detection function. Add new feature
so that it can be enabled, disabled or queried at runtime.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 include/uapi/linux/rtc.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
index 97aca4503a6a3..596eec119bb3a 100644
--- a/include/uapi/linux/rtc.h
+++ b/include/uapi/linux/rtc.h
@@ -134,18 +134,23 @@ struct rtc_param {
 #define RTC_FEATURE_CORRECTION		5
 #define RTC_FEATURE_BACKUP_SWITCH_MODE	6
 #define RTC_FEATURE_ALARM_WAKEUP_ONLY	7
-#define RTC_FEATURE_CNT			8
+#define RTC_FEATURE_BATTERY_LOW_DETECT	8
+#define RTC_FEATURE_CNT			9
 
 /* parameter list */
 #define RTC_PARAM_FEATURES		0
 #define RTC_PARAM_CORRECTION		1
 #define RTC_PARAM_BACKUP_SWITCH_MODE	2
+#define RTC_PARAM_BATTERY_LOW_DETECT	3
 
 #define RTC_BSM_DISABLED	0
 #define RTC_BSM_DIRECT		1
 #define RTC_BSM_LEVEL		2
 #define RTC_BSM_STANDBY		3
 
+#define RTC_BATTERY_LOW_DETECT_DISABLED	0
+#define RTC_BATTERY_LOW_DETECT_ENABLED	1
+
 #define RTC_MAX_FREQ	8192
 
 
-- 
2.47.3

