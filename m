Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527720;
	b=HsIUeEa+bqWOcAqy6WCsJgicZZB/aiOcD8PHx3dl7+kkwwajO+bGNu4Sgm7Ctee9Rrnq
	 pfqvLyqpzElicraQjaGEOHl5RyvsmKzg3XhdXFvAOYh/MsorvSC+qXKTSlvAsk7PGje0M
	 9VC6ySUCxXZiQd/kziAD1p4n7UzOsRB3huuE5W120VNd3PH2mOKPSMhrjJpZ2kHH7kNEI
	 0SeIhqsiL7QywsVotLE+EVaYSddMf6ZNh3/H1ZUqa4WCvY9oPRCxA52ls8TvCntGLtZbW
	 DOjS+Kj6zL3D1YBXy8C3INP97npv3ehJMlPaz+67gHzkr3R1mtVd2HYGNa6OzY2c8QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527720;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=P9l0BuMqwnltE+aYWTNXRfGtQwMjaLgJX4iwc9Of5kw=;
	b=Fp+v/12otOS5ScNCq+E51sCrEY/1bCBnmCy7T54r1Ss0F9dznkUMU9I/RVUkGBb/lGUz
	 XfTtn4AdVSvSJy9ShooZW+cU1oWzYWty65GIqQMtiDWOiWBDrC9Px481JXFWj01Y/y38V
	 w1ssC+SDkDIlCC8ZkxNV+gcCVY6rfnaOmjlHuCcErbsVifT8xq1ZgjKQ4E4f4Vo+KcS19
	 5gtA0XRS1Aq66hyPGWPLC4wVsz4sw4/+4FnV2z9n1W4otDsZLzRtJFecmx9s4M8Xz8RBO
	 dce6vKAYxVZC+DGb6nHIbmavSqTHd3E9cRjBCJqfH+r7WOuQC6E5i9NcdDok8BdK7cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCNXDzFw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73943606A331
	for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCNXDzFw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBB91F000C0;
	Tue, 24 Nov 2026 13:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795527720;
	bh=P9l0BuMqwnltE+aYWTNXRfGtQwMjaLgJX4iwc9Of5kw=;
	h=From:To:Cc:Subject:Date;
	b=JCNXDzFwsbCDZbQnumlDQYY5z4s5/GfnCsgWfsukb3VUaYzZ10eHandv7BFUS+kCi
	 BgwfX4dIqM3pyDqKcNGvrieIanDnVUymoQnBk02qfPj2B8a2hMHecbjGl3VNxm9Wn2
	 /G1eIo6ovOri2NAkFbXi/LDGatJkMuAmuphfYBNgCEEfGVLIyHmE5RUUQWbqSFK7q6
	 HMu+lpXOMjvrTyUnB7LCVWUy737yZTCijMg/1u/3XDySu1H57wArLTz5OHiQ6WjJkJ
	 pqOBCROsSbZe1BcrAZfwnAlY3xYazBu8gHVWfTG5nhvlKNppkpw4PTKFaSljK9ijd1
	 kcjiYEw9ibrxg==
From: Thorsten Blum <blum@kernel.org>
To: =?UTF-8?q?T=C3=B3th=20J=C3=A1nos?= <gomba007@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <bence98@sch.bme.hu>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: sd2405al: Fix BCD encoding of the month
Date: Tue, 24 Nov 2026 14:41:11 +0100
Message-ID: <20261124134110.237481-2-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=blum@kernel.org; h=from:subject; bh=2TDB59fBRHzYnYAnitdqlzxCHjD9itsv0tlqb8BCxOo=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDNmsk795PZjObCr8oFzR4tgiWb3F0VOy2QL0ZvM8Ydnl2 fn7x5VPHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjARFW2GP5wXeqVbuU4+zd9u 377PX9TOtVoq+lxGxqEw0Vdy/yx6LzD8T3L7/3ld1WL7eZd6z3leNlxq9rQhfh7vO6bM6Uc8Y++ c4wIA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

The SD2405AL expects a one-based month encoded as BCD, while tm_mon is
zero-based. Adding 1 after converting tm_mon to BCD incorrectly encodes
October as 0x0a instead of 0x10.

Add 1 to tm_mon before converting it to BCD.

Fixes: 5af858acea22 ("rtc: Add driver for SD2405AL")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/rtc/rtc-sd2405al.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sd2405al.c b/drivers/rtc/rtc-sd2405al.c
index 990080f09457..5f023e3abac8 100644
--- a/drivers/rtc/rtc-sd2405al.c
+++ b/drivers/rtc/rtc-sd2405al.c
@@ -129,7 +129,7 @@ static int sd2405al_set_time(struct device *dev, struct rtc_time *time)
 	data[SD2405AL_REG_T_HOUR] = bin2bcd(time->tm_hour) | SD2405AL_BIT_24H;
 	data[SD2405AL_REG_T_DAY] = bin2bcd(time->tm_mday);
 	data[SD2405AL_REG_T_WEEK] = bin2bcd(time->tm_wday);
-	data[SD2405AL_REG_T_MON] = bin2bcd(time->tm_mon) + 1;
+	data[SD2405AL_REG_T_MON] = bin2bcd(time->tm_mon + 1);
 	data[SD2405AL_REG_T_YEAR] = bin2bcd(time->tm_year - 100);
 
 	ret = sd2405al_enable_reg_write(sd2405al);
