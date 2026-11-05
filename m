Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864282;
	b=DwPeiIfwtiUFIxRTMxkwxT01CGa+OBtPSibNRfmx7D2ArX7KKklKC9xog/KEie4cAFtq
	 Vwx5wlY3bI+3MCefo3S4G/jDPfvlEKrguA+/yr5aImf+9eQ80oHoWhZtQ3pJ07Jj9/Vea
	 9d8k0mHBm+jNGw/Z6279i1ZhtikIRaL0T1TvguPp2QsR3AR3rKyn1LAkjyKEqfSWQ7Q6U
	 2pnvbdPkDWgNj5VvL7YaFRaeJmvvK+4Jz156z+yl3JMoRr07tUzAWci3z8+93pjqWg79V
	 3IqbmXJ83LqCTnGulS3m+10dzFSd/LraF0LM2n2KU8GcHgxnZhgCDT5r/3JG3RPoLmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864282;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=O+DefVadtLa6SPaklYpaHc8GZx+rmsOjmeUFC9PQ6G8=;
	b=LhfTySBaw+xTHwUOI2rYp86eUFtptvhKy1Vn04LkuY9HZxXUM6AijxmzGecrovpqKs7J
	 JX/nD7SPoskxsfN0UD/pRcdJMcXc0QKLjqnV79vkGFnwg5ADEFD3vNNi7wA05WW72sDhK
	 zkphhV/jpF9LLghRDwLjfzs/fjoMBs/cjGB8hsTusb0vhNQ1ajVrWRzV3hOHqkhyvrzPE
	 iwJ0Zo3M9BMdMD7gJAX8OGG+McOg5ImKwMEXSljFVBBVDuI0TMHamaId8DHmZP8t19k7P
	 f3A4j8a0xwdye1EHSPkD6Zc2wNt3B+WFaJ+XgBcYW0muWOQDRPQLEi7yay7y91a508w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=Cno54tmj;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 406C8606A31B;
	Thu,  5 Nov 2026 07:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 406C8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=Cno54tmj
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	<linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] rtc: interface: skip the RTC read in rtc_timer_do_work() on an empty queue
Date: Thu, 5 Nov 2026 15:37:42 +0800
Message-ID: <20261105073742.2193-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc12.internal.baidu.com (172.31.51.12) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793864276;
	bh=O+DefVadtLa6SPaklYpaHc8GZx+rmsOjmeUFC9PQ6G8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=Cno54tmj4wTuN3ciBdGPpwjo+RD+6741yC02XkHL9cLwoJJKY8AebK2ZhvIZg+YKW
	 z36btYR2q5no0pC9xLDeqjPk/DhCdNG0qYN6rk9STSK+S4fGp7IVejKjzoAPX7SyTW
	 2YVR4bs8NZGzkxvYuirK3j3SBLGc3URA0xUVaaNDw/E6YIecnRazfZcVjouAh98po4
	 2LgphnMEm6N5JTnW4SqlKx73MArCCIqXH5AGZfDuFNe/PQM/47Aa0dTZGCvsdsTGrU
	 FcMOcs6fJ4YWIb5VycG4SdPqrxtn5KrLuuidVTh2N2YlwQ6qnSMiaPg5Ink6PBCw9e
	 G20rX2f+erHlA==

From: Li RongQing <lirongqing@baidu.com>

After rtc_set_time(), the RTC core schedules rtc->irqwork to re-read
the clock and reprocess the timer queue.

When the timer queue is empty, there is no timer to expire and no
next alarm to program, so reading the RTC is unnecessary. However,
an RTC read can take up to 3ms on some systems, blocking the CPU for
a significant amount of time. Even on faster systems, it can still
take around 50us.

Check whether the timer queue is empty under ops_lock before reading
the RTC. If it is empty, release the lock and return immediately.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/rtc/interface.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 96626f8..a65b594 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -977,6 +977,11 @@ void rtc_timer_do_work(struct work_struct *work)
 		container_of(work, struct rtc_device, irqwork);
 
 	mutex_lock(&rtc->ops_lock);
+	if (!timerqueue_getnext(&rtc->timerqueue)) {
+		pm_relax(rtc->dev.parent);
+		mutex_unlock(&rtc->ops_lock);
+		return;
+	}
 again:
 	err = __rtc_read_time(rtc, &tm);
 	if (err) {
-- 
2.9.4

