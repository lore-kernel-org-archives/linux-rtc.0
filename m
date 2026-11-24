Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527893;
	b=Z9+fOrJbAaHTPW+Br4h3P0JZ1ofSS/UwS/TJvPaZrUVnfr7gHbbsldKvdfAioOF9wd/H
	 1QLziwQJAYpWBVFL6qNsyoescWxFz1r+CVKrukbXELFDPiAT71Tetl4lJlzEsDwur33fG
	 QplIALiBSIre8WqARYRwiOQg9clN1jGyQBYvPzQFxJEOUswM92X8VzTIoJQ4G23blO9zS
	 oPiVyvrSDGxu95YdN+wILjOL/XcSZh0evz2nvOmHQ7fLMEuBlHtFX+RLYaQofPtwOdx0l
	 9+tCD5QE3s5UE4uojmVhjenlMpmVy/vfDdf2iQPBOOG1dpg6lYWDanyiK1ldADNEQtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527893;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=aickpwpH6ChZuYUr8UlvUDuJVFqN05Kq+gqd0nx1itY=;
	b=sOFEQnpqzqQRsuENG8+3vt+Kld9CUU9LgPDGE5AnLfXE89CjSuVadTnaUn/cY3zAeV6v
	 KUnOO/jv+dFgwmdxx8GYzRW+aNVYtZ4oxUDkYaaLOYU+PBCthCpL4ZkxQN+oFyYpP5k0a
	 W48BneK2Nei5BInTwRTJiNiawvnG7Wi5ruZV1kfYswA4ASaHA2baeQAWcDUxRbeCwPKFc
	 c1tbM0U6IzeT/RJ8mhTzHCTaekyFzAgmL/ARKDqcB01y7IHDgvhBQvpTp+ocwtq9Qrxjy
	 jXvzA/Euh0tL4K7L/XPCUdoRIEOZvprQfSDAoSbrypLhZdEhiczOFgckGtup0mMzOQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrUK2mow;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6ED606A31E
	for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrUK2mow
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821321F000D2;
	Tue, 24 Nov 2026 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795527892;
	bh=aickpwpH6ChZuYUr8UlvUDuJVFqN05Kq+gqd0nx1itY=;
	h=From:To:Cc:Subject:Date;
	b=HrUK2mowX2/TOdDfVbP9XiyJAymgkCBWckcy8kxQgJT4X2qXzcN9pjsAmZKNFDsn5
	 4x5MRVDsWaxjUaCIAPf+7eMFRt/RH0Qk0/ZO9Rq8H29tUOSKrcMmBkeXadh4zLdI4u
	 z6UpmAcyo4Sns1pijt5nZ0VTrip57gdjMmieOayRJaq9eWYNyqr3O808S8yxf2cHgH
	 bEi+0eODIHB+j0RBJlQJ9uP9V+p/RRRfN+TR8zJLvWFl3jEE5ZlquRF1CU9xbx3vml
	 51zU0t0Rygdl7HtaCio3CtCv+5lzEXGZCyA0Ub7b3QggRd9nonlvCEcTQ+/aU+sZdj
	 Jw4xIAYqx4m+g==
From: Thorsten Blum <blum@kernel.org>
To: Dianlong Li <long17.cool@163.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: sd3078: Fix BCD encoding of the month
Date: Tue, 24 Nov 2026 14:43:09 +0100
Message-ID: <20261124134309.237707-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=blum@kernel.org; h=from:subject; bh=uapli0g+wcqzA+IgQlatH8AKIcHIP8T1AQNhkp1wOzI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDNmsU3LbDJeYhYs77EqT4HRV73yxkvWFQcn7J+53TeZaq P6UnLa3o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACbCFMfI8ONYlfHFan/Hbb5s aeGFd9ebGa3YI6vD8ZiBTez4nmtq2owMW/mefGQ+U9DJtHHd5iNPZaq3ufZdbOI6XBe8Zn9ZhoA hAwA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

The SD3078 expects a one-based month encoded as BCD, while tm_mon is
zero-based. Adding 1 after converting tm_mon to BCD incorrectly encodes
October as 0x0a instead of 0x10.

Add 1 to tm_mon before converting it to BCD.

Fixes: 1d67a232105b ("rtc: sd3078: new driver.")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/rtc/rtc-sd3078.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sd3078.c b/drivers/rtc/rtc-sd3078.c
index 2c61f0e204a4..7ceb6f866492 100644
--- a/drivers/rtc/rtc-sd3078.c
+++ b/drivers/rtc/rtc-sd3078.c
@@ -119,7 +119,7 @@ static int sd3078_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	rtc_data[SD3078_REG_HR] = bin2bcd(tm->tm_hour) | 0x80;
 	rtc_data[SD3078_REG_DM] = bin2bcd(tm->tm_mday);
 	rtc_data[SD3078_REG_DW] = tm->tm_wday & 0x07;
-	rtc_data[SD3078_REG_MO] = bin2bcd(tm->tm_mon) + 1;
+	rtc_data[SD3078_REG_MO] = bin2bcd(tm->tm_mon + 1);
 	rtc_data[SD3078_REG_YR] = bin2bcd(tm->tm_year - 100);
 
 #if WRITE_PROTECT_EN
