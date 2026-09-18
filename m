Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8392DC76A
	for <linux-rtc@vger.kernel.org>; Fri, 18 Sep 2026 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748374; cv=none; b=V/5S3ybGi+D7UJC0S5z6oqWfoZP0vARDEPcbHB6U0cPFSxbeZ5/+VYtO2le7pD3MCbW1YXmWV3yNOUoSSrNdOH63nfB2jXfiTjyGjY29w6ETdbOhOec2AD/TEOhpEIEX08jVyfauRwrY+c26Eb63sUuRFIP/EVMIOZJCm5S0uLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748374; c=relaxed/simple;
	bh=eHoxMD49RuFV3Eb4It0nXTbB/TWFeAo0DHVY9dkLnxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rEVkPB0SjHrnnBq8re9AhqDXLd2ps9YM2T7QO9Mk3mhaQ4Zv/3PBNbjKpWXPt1NncRyKiKM6OeB3rQCX7YtmzEiycgBMCS6X8IosMP36ckqM1dxwKWMKuPxo6NNZxhyjwxekHti1arCMRdckzZGRVsPJdgHOdauXtz3SAmJsQBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAdh59eA; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAdh59eA"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso903801a91.1
        for <linux-rtc@vger.kernel.org>; Fri, 18 Sep 2026 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748372; x=1790353172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JrqHy/Ltwsv9DxVnw14hRzfEI6+yxaAfvyb1bklLGNA=;
        b=QAdh59eAUjRsBuLu4EfBRJXnNgwc84tmmWvA11qA71PNIE0RZdY8fmxJbnc6QPR7Tj
         wvamDcp0QUCjXiQ3Em3Lfg11DrOO8gBBMCh1EhWeI4n5NgR+lOdAxTUhC0xuAv9mFBYN
         ZGVFHUP3Ra2+FuSDA5MqYCl96BmSbPxACu6WhdSwpRIJsdItsPjvEBbEVcFmD9s5lvDl
         1F+LWPLrQB/Z/OepdC8K/yZ+y/wj2Qhj9kuK36OK/YigwJkbTMbTaFOwKszsVCkYR+6L
         YumN14HqUT0XYhter0x0z3iZHtgBvLAZeF4ShaNS//rHh6yBsnTzHrUu/PAg12jHOOW2
         wMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748372; x=1790353172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JrqHy/Ltwsv9DxVnw14hRzfEI6+yxaAfvyb1bklLGNA=;
        b=G2Cnr0DWn0cQohi2WcPWAT5CETN0dn3iWanZDIES3G9DCVqlJAb2RLMNhuIq3qK7Ur
         Z+abSIYvBun2ycCpvY2BFL3fklCndorB4UX4wZpsJd4lJagq/dW1aXXm7tSKXYWr8dvU
         8upEIWhH+scLCM3UlP+PpMvXrtlDUPvE0DgY5Qbd1+DYxnxqAo2FdKh8Ad1y/ME/xG3n
         FDLb13EKi5qppEDCxcZSXMBnwsHdzcw2B2fX6yLHaS9ce4HfA9GlD3FCpubzDN4rpUHr
         alruMDe0V2Es0C76G2oO8VGYJq8aAIyICJDh6vW+JyLTkXNOFbzYLEEBuLKY2ZkQzljj
         x/iw==
X-Forwarded-Encrypted: i=1; AKwUvBwYXQ+LZ+Js793HunMBJEL1KV8eqGesc+GywUeOWIV/kl/QconHqBwWJfk0dEeD/Q7Rlj0Ro378xZw=@vger.kernel.org
X-Gm-Message-State: AFuF++nHA+WWGV/gJERa/G+vC5dVUyx1eYcXPtiq7960UgoJlj0g4Aj2
	wn4ZpGvptx3wSrMupyJhMrbINvjGcTC9FdGoRWWIt+iYRBydaqv38oGZCGxckw==
X-Gm-Gg: AYBFou0HLBQ5PXvCVaXvNWZxOQMwb/49yBqLj2WXDpSoneQKPz4cA0AEeeFDy/X5RtP
	kiy9J2lzdQIOGv2Beyq1PgCdCDzPPaySANOk07X1d+f/XiGyy1io/qjf+g8Uj4mJ8q2UNpXHPY6
	2753fDkQ4jyw70qd47wRPtFogRXs4DK5sjMXfsvac0SoOqGTZ+6mmOVp/8tQ+IVbfSxatB4NFFP
	ck7oD2sk55zjd6ij9TtpNLiHkQOqLnrO6THMO8sxmOHswzGQMcb+MHVw+YB6cdR3NVNqX1LBZ2t
	7lJ8UCdxD4tCbvUvBAYZjUBy6Oe/dPJVmkG7qRMNCz3fwMuyr8b9boaxto6YKoHhSj34HTtVAhd
	2ILp27n8Rsp28uDebzQDrymh0asGb4r5/qhJTjltvlUrxkcroBGMf2bKVoeiETQmNPuh6vut50Q
	zdOfqTsJj1VRE4p6CCzE4HBHUTxmtDw7uiSySRs8hmwQOYDKwBT1Y3yrB305DX5XElqCdC+LGNg
	KCmXmVHtQ43wFHi
X-Received: by 2002:a17:90b:5403:b0:39e:6a7f:eeed with SMTP id 98e67ed59e1d1-39e6a7ff0b0mr1221280a91.18.1789748372302;
        Fri, 18 Sep 2026 09:19:32 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce046d96sm4934242c88.11.2026.09.18.09.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:19:31 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Jacky Huang <ychuang3@nuvoton.com>
Cc: Shan-Chun Hung <schung@nuvoton.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: ma35d1: fix unchecked IRQ error and IRQ-before-rtcdev ordering
Date: Fri, 18 Sep 2026 23:19:25 +0700
Message-Id: <20260918161925.2639130-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

platform_get_irq()'s return goes straight into rtc->irq_num and then
devm_request_irq()'s unsigned int irq parameter with no check --
passing a negative error (like -EPROBE_DEFER) through that conversion
turns it into a large positive number, so devm_request_irq() just
fails with -EINVAL instead of deferring the probe.

Separately, the IRQ is requested before rtc->rtcdev is allocated and
registered. Since devm teardown is LIFO, unbind or a later probe
failure frees rtcdev before the IRQ, so an alarm firing in that window
has ma35d1_rtc_interrupt() call rtc_update_irq() on freed memory.

Check irq_num for a negative return, and move the IRQ request to
after the RTC device is fully registered.

Fixes: dc0684adf3b6 ("rtc: Add driver for Nuvoton ma35d1 rtc controller")
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260914133532.CBFAA1F000FF@smtp.kernel.org
Assisted-by: LLM
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/rtc/rtc-ma35d1.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ma35d1.c b/drivers/rtc/rtc-ma35d1.c
index cfcfc28060f6..76d59b313721 100644
--- a/drivers/rtc/rtc-ma35d1.c
+++ b/drivers/rtc/rtc-ma35d1.c
@@ -236,11 +236,8 @@ static int ma35d1_rtc_probe(struct platform_device *pdev)
 	}
 
 	rtc->irq_num = platform_get_irq(pdev, 0);
-
-	ret = devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
-			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "Failed to request rtc irq\n");
+	if (rtc->irq_num < 0)
+		return dev_err_probe(&pdev->dev, rtc->irq_num, "failed to get rtc irq\n");
 
 	platform_set_drvdata(pdev, rtc);
 
@@ -258,6 +255,11 @@ static int ma35d1_rtc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to register rtc device\n");
 
+	ret = devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
+			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to request rtc irq\n");
+
 	return 0;
 }
 
-- 
2.25.1

