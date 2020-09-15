Return-Path: <SRS0=5D1E=CY=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2646EC433E2
	for <linux-rtc@archiver.kernel.org>; Tue, 15 Sep 2020 09:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC0172078D
	for <linux-rtc@archiver.kernel.org>; Tue, 15 Sep 2020 09:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIOJWB (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 15 Sep 2020 05:22:01 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:39633 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgIOJWB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 15 Sep 2020 05:22:01 -0400
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id CD7B8240002;
        Tue, 15 Sep 2020 09:21:58 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] rtc: st-lpc: Constify st_rtc_ops
Date:   Tue, 15 Sep 2020 11:21:58 +0200
Message-Id: <160016171046.325179.3123778161718568231.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200913122644.35515-1-rikard.falkeborn@gmail.com>
References: <20200913122644.35515-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Sun, 13 Sep 2020 14:26:44 +0200, Rikard Falkeborn wrote:
> The only usage of st_rtc_ops is to assign its address to the ops field
> in the rtc_device struct. which is a const pointer. Make it const to
> allow the compiler to put it in read-only memory.

Applied, thanks!

[1/1] rtc: st-lpc: Constify st_rtc_ops
      commit: d0a3b65052f041852c855ea1135659770ba0bc09

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
