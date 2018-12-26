Return-Path: <SRS0=XqKi=PD=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2CBC43387
	for <linux-rtc@archiver.kernel.org>; Wed, 26 Dec 2018 11:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68605214C6
	for <linux-rtc@archiver.kernel.org>; Wed, 26 Dec 2018 11:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=crashcourse.ca header.i=@crashcourse.ca header.b="nk4qrdSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeLZLqw (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 26 Dec 2018 06:46:52 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:49332 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbeLZLqv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 26 Dec 2018 06:46:51 -0500
X-Greylist: delayed 1658 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Dec 2018 06:46:51 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NcTN7symjP5w+ghFCXtJtTWmcn2Q1kvMEacqNRH0Pac=; b=nk4qrdSjSdPcokFS37TFhLBBhB
        7D3G2gMjxoGNJbdLR+gWYtOBMB9hH6ug7l1ZkBqWd4PMs1nBBQo61MDZYDlpKVlZk9rcQ369tGBh4
        Cf/YjRTufHINHx1TT4drTlpp/CImalj2HurdvIcK7eAedH6+Ur1leQQXUvJvXVr+y0dBexCkjTgfg
        p+niieJX5d3nAD33a2QbdBw7IUT0F+7/2I56wjxUfeeez6fuGkyewofRiOlFo3X1O6t5tjbp45E7F
        I3rURmKhczitwHbOq/KQ+j7HLdomAn0hq8q3c5tniAVNi0gKB7JbZgNMGmjqxjHQy7LKxl/KLRH5J
        +zlj05pQ==;
Received: from wnpgmb0903w-ds01-77-135.dynamic.bellmts.net ([207.161.77.135]:59354 helo=IT-590-06364)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gc7DS-001A9A-Ue; Wed, 26 Dec 2018 06:19:11 -0500
Date:   Wed, 26 Dec 2018 05:18:33 -0600 (CST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@IT-590-06364.gateway.2wire.net
To:     linux-rtc@vger.kernel.org
cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Subject: [PATCH] RTC: fix erroneous kerneldoc comment
Message-ID: <alpine.LFD.2.21.1812260516220.31274@IT-590-06364.gateway.2wire.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org


Clearly a copy-and paste error.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 3b43787f154b..df45d9a01ff2 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -425,7 +425,7 @@ struct rtc_device *devm_rtc_device_register(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_rtc_device_register);

 /**
- * devm_rtc_device_unregister - resource managed devm_rtc_device_unregister()
+ * devm_rtc_device_unregister - resource managed rtc_device_unregister()
  * @dev: the device to unregister
  * @rtc: the RTC class device to unregister
  *

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
