Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611631;
	b=b16fD/d4ksL8MsG9kYsYcRJnukWIBZy4m3qygPAQq6BZbppvytx/2Ld9TKv9iSVM9n3n
	 4nnA/JwdpodyMM8p5UBij1/4y5oOM8YaQlMW7HrG6jNhT2Upg0nz2dgrmPhWuRGv5/zEZ
	 b8hg4+bjKusoWLrrK6HlZsVl1fFl2qdtEjo5DwCTQbhCusLX9WFNqcauNa9OcupmUPOBD
	 ByA1Gtrbrrl17DqV68Iq1NFagqz/oZi6dOPN2p2lFKEZXexk2UwAFh2pk6Zjk3ruU7O2D
	 Pj+hdv1QRp2Yvb0/EdNO6SoLZgan1uXc5kCjrmRiChxtnQ//jxa87Y/JwC/rKlbyv6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=EG6s7IXphn6NOHl4nh68/lOvSTp0F1fia3IQ49tN0fQ=;
	b=BL61Ez3Xo/9u03O2fowOEzTrNOyYA7AZpbd9chkAoid0yYByDQ7djXamIcsWmyp/gw68
	 QHEUdYeiLxUge8KoU1LQC8DT/Jl12BPo9lRe43AZR5IM5KvLfIdBZl53h7+FgOgoWR6oI
	 gKIcM49rvFj5KJ6IgC0PyHVuqg7hd3sHW25ml3olC86tLS723hEqhuvvpbgAflVoStxUa
	 iUkj8plYXYtGFI7ZIqnQPYHHBJqvePShfOoygRcOyz4iqf/n7F7ScqxHRXEJbc/wVmf38
	 mmlewDy3T68g/8CjkFLMYd9DBpDahSVVDjZonjpvi5FW+Fawzme+IfYysBlKcfFOyoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSt4dPSK;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5D606A327
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 23:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AC5D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSt4dPSK
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-377f12217c7so1494077eec.1
        for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 15:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611628; x=1795216428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EG6s7IXphn6NOHl4nh68/lOvSTp0F1fia3IQ49tN0fQ=;
        b=jSt4dPSKRruz1pY4S3eqCOEYbFc0io6eBEJdLq2NG76YVTJ8IGs2hx1WtYgcA1+Ls4
         Ws2si2Q3MZYlxOemx2wdJplId73D9rjtU0SPNetFUHe1K/VL5jujBckLG5iklZZCIcrg
         +I94mNsDT9FjVD+Zbx0EhPu+P84+IDWj5EJNS49BJ/efznOf9mhE8nsujcCXLD8QLBa/
         fqR/w6yXBnHrLarWXQBqIs8lKxrrI1Ak//xYc/2nXqfr2A7R2hOAw17U5+g0kUJM55G9
         szjj1VJoxlxA8+kBUHgw1/L7oWUZMhXOah19zpQyUPRlKdbSNqjZMRFDY0KAb5G0nRQL
         rnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611628; x=1795216428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EG6s7IXphn6NOHl4nh68/lOvSTp0F1fia3IQ49tN0fQ=;
        b=sWXnkUgf1uBruPZYV2pArhKpo9+g3Ob1Vvo4G6I+a+vvkKnu6JhtKreZ2vI+p3BGzJ
         DAooQDHwFSI71NnuLpKCOdhLvI4iC82rjIFK5FITefkyr9heVyQRzHUIuYeLmTqDRlrp
         ct1bw0+u9viNKSHhRiZmKYSq+oyWzAXqGP7RfrzEwc+5KUzWGCHKp/7vNhbUioZEHZNi
         EKV4/r4RpgOsQIUIWIyhVIW6F8j0dg1MNfprJUVAywgOc4Ejf+VAxWmWapJJB/upMalm
         H8DzIx88sP3Phz25K4macppo5Lfm8mspjzxJNsW8eC+PtybuX34wAWS6IrEHvdxHgYOH
         0OLw==
X-Gm-Message-State: APuU4Z85zHxYqeRPrVtAz+2mEX0cyN0RUMnSPSp4SHasIdjEV0/6YUpd
	gkKB1pmCpV7Y84qvCV3hP/iiN7JXEl6UX+xxeLj1XICrN59O9lxUeEuB
X-Gm-Gg: AYBFou37AwnhYI9UDroG3s4bEq/bigqQZJbMftpGKKaK7uqTiTIX7skrzO3T05idpvg
	ocSX1qA9e8cSXnmItTHldVumgZNjeg/96wkqN61dtXZr4s6gUWBeR9fBwsnHLQcVSzVt6epzLfc
	YdJ6Vn5ziTfO/no1X5hW8DO1vAfqWxfUkbSTE3XNn2Wpcr0iEx1PUtjbQkI5I9Q/VgBZZoG2L08
	on4aLq49eWJKS0E6/fhB5CFhtLpGG0yGpz6QY9qsJKGqc7bzuOrnZAgtIsvhwHP29HUQWx0spdb
	NvlWRDPLJZ/gN/efwwPDn3RMKknk2J+UAF2gbudjoXWlmEiIZ9udgKaAzafaW3Vc8zBpNByju7X
	Z7OkgtUKw5yqXZfx/cK+n3KSolrb2KXMe3f4L2fXYMjhBhdYugxkQNR6+jgAR2+lz8q//aQW0O6
	k38wQOHcfsAQLUBtCG3RDsQEkJ1eRrjkRND5JsS+OO0zQTDD502hSY5ryD/j6ls3xJgbdT1+3Cl
	NSFzm2V5tLAoeJ+oF+DDZgvTXWh83/e71WkbHjMmlXch1lSSvZ7a/AaFb67ihEo3pMYSJLxZWi9
	MuRlUiLwbTxNFYd+AR5IE6vJiT454gfhLcOpqIbnJyQLugxHLs6zTFeWf/LMOxn7KWnhySYwBmb
	LnM9YIx22uzXng1MGtXsuGW0OpT8QcZjHtPvg3IYQG2XjinNNmb0D3S8lxHs=
X-Received: by 2002:a05:7300:d718:b0:36a:12c1:3adb with SMTP id 5a478bee46e88-37966b52740mr4985969eec.20.1794611627449;
        Fri, 13 Nov 2026 15:13:47 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955822d58sm9922842eec.10.2026.11.13.15.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:13:47 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Shubhi Garg <shgarg@nvidia.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] rtc: nvidia-vrs10: Disable IRQ wake when resume fails
Date: Fri, 13 Nov 2026 23:13:27 +0000
Message-ID: <20261113231327.22109-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvvrs_rtc_suspend() enables IRQ wake, but nvvrs_rtc_resume() returns
early if the I2C access to clear FORCE_ACT fails. This leaves a wake
reference held across later suspend and resume cycles.

Disable IRQ wake on the error path before returning the I2C error.

Fixes: 9d6d6b06933c ("rtc: nvvrs: add NVIDIA VRS RTC device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/rtc/rtc-nvidia-vrs10.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-nvidia-vrs10.c b/drivers/rtc/rtc-nvidia-vrs10.c
index caac63f4e0fc..a5e73baf03a5 100644
--- a/drivers/rtc/rtc-nvidia-vrs10.c
+++ b/drivers/rtc/rtc-nvidia-vrs10.c
@@ -505,6 +505,7 @@ static int nvvrs_rtc_resume(struct device *dev)
 		if (ret < 0) {
 			dev_err(info->dev, "Failed to clear FORCE_ACT bit (%d)\n",
 				ret);
+			disable_irq_wake(info->irq);
 			return ret;
 		}
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
