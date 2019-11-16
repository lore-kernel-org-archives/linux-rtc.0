Return-Path: <SRS0=r8Ha=ZI=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F21C33C9C
	for <linux-rtc@archiver.kernel.org>; Sat, 16 Nov 2019 15:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25ACB20815
	for <linux-rtc@archiver.kernel.org>; Sat, 16 Nov 2019 15:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919909;
	bh=D6JT7FvDOOq9sWuwoDemas30vIqXwcUFtXk+E/9t1d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oqN/Nrs+ks6pZOMTc8DVcPx3pmfmJAuUFUO6S4VFtzaE5gPDWus9uiaTdOxDCKrsN
	 5JDAdrr7zDOrNnx9dBNCBTTsrgZmv1DUOSWPInu/z+yAG1TgrBezlM06bY5WUh4A4G
	 +ek0GoaGWUAV9Kf7ndSyR94Q4BnBTvLvx06nFztA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfKPPyV (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:54:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731423AbfKPPyV (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sat, 16 Nov 2019 10:54:21 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F84221882;
        Sat, 16 Nov 2019 15:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919660;
        bh=D6JT7FvDOOq9sWuwoDemas30vIqXwcUFtXk+E/9t1d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m//isy9lybY/sUZvDFQVsXP3YSYisSVo8njDjLx6JIg9kU8eSjALJXmyO0eOdW5bN
         nZxA4i8MPI2GNiwtcm5tnT+uW3y9zujNKzQEsU/6toa+lwYQhTig5JU+t9skQbBTZy
         rPn3Bl/hBoSgzj+W6aTQsNIVlVsjKivUsRTXN0UA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.4 33/77] rtc: s35390a: Change buf's type to u8 in s35390a_init
Date:   Sat, 16 Nov 2019 10:52:55 -0500
Message-Id: <20191116155339.11909-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155339.11909-1-sashal@kernel.org>
References: <20191116155339.11909-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit ef0f02fd69a02b50e468a4ddbe33e3d81671e248 ]

Clang warns:

drivers/rtc/rtc-s35390a.c:124:27: warning: implicit conversion from
'int' to 'char' changes value from 192 to -64 [-Wconstant-conversion]
        buf = S35390A_FLAG_RESET | S35390A_FLAG_24H;
            ~ ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
1 warning generated.

Update buf to be an unsigned 8-bit integer, which matches the buf member
in struct i2c_msg.

https://github.com/ClangBuiltLinux/linux/issues/145
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-s35390a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 00662dd28d66a..9a931efd50d36 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -106,7 +106,7 @@ static int s35390a_get_reg(struct s35390a *s35390a, int reg, char *buf, int len)
  */
 static int s35390a_reset(struct s35390a *s35390a, char *status1)
 {
-	char buf;
+	u8 buf;
 	int ret;
 	unsigned initcount = 0;
 
-- 
2.20.1

