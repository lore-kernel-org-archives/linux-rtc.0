Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223DBC5519F
	for <linux-rtc@archiver.kernel.org>; Sat, 14 Nov 2020 22:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E044A2344C
	for <linux-rtc@archiver.kernel.org>; Sat, 14 Nov 2020 22:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgKNWhZ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 14 Nov 2020 17:37:25 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49893 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgKNWhZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 14 Nov 2020 17:37:25 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1390360002;
        Sat, 14 Nov 2020 22:37:22 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2] rtc: hym8563: enable wakeup when applicable
Date:   Sat, 14 Nov 2020 23:37:21 +0100
Message-Id: <160539337060.848153.7453047020568943030.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1ea023e2ba50a4dab6e39be93d7de3146af71a60.1604653374.git.guillaume.tucker@collabora.com>
References: <1ea023e2ba50a4dab6e39be93d7de3146af71a60.1604653374.git.guillaume.tucker@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Fri, 6 Nov 2020 09:06:31 +0000, Guillaume Tucker wrote:
> Enable wakeup in the hym8563 driver if the IRQ was successfully
> requested or if wakeup-source is set in the devicetree.
> 
> As per the description of device_init_wakeup(), it should be enabled
> for "devices that everyone expects to be wakeup sources".  One would
> expect this to be the case with a real-time clock.
> 
> [...]

Applied, thanks!

[1/1] rtc: hym8563: enable wakeup when applicable
      commit: c56ac7a0f468ceb38d24db41f4446d98ab94da2d

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
