Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBA6C433E0
	for <linux-rtc@archiver.kernel.org>; Sun, 28 Mar 2021 21:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694636195D
	for <linux-rtc@archiver.kernel.org>; Sun, 28 Mar 2021 21:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhC1VOZ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 28 Mar 2021 17:14:25 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:39981 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhC1VOI (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 28 Mar 2021 17:14:08 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5A85E20002;
        Sun, 28 Mar 2021 21:14:04 +0000 (UTC)
Date:   Sun, 28 Mar 2021 23:14:03 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Kirill Kapranov <kirill.kapranov@compulab.co.il>
Cc:     a.zummo@towertech.it, phdm@macqel.be, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] rtc:abx80x: Enable distributed digital calibration
Message-ID: <YGDxm/zJSETUMY4B@piout.net>
References: <20210328210232.10395-1-kirill.kapranov@compulab.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328210232.10395-1-kirill.kapranov@compulab.co.il>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hello,

Thank you for working on that!

On 29/03/2021 00:02:28+0300, Kirill Kapranov wrote:
> This patch series enables a Distributed Digital Calibration function for
> the RTC of the family. This feature allows to improve the RTC accuracy by
> means of compensation an XT oscillator drift. To learn more, see:
> AB08XX Series Ultra Low Power RTC IC User's Guide
> https://abracon.com/realtimeclock/AB08XX-Application-Manual.pdf
> 
> The patches 1 and 2 enable SQW output, that is necessary for subsequent
> measurement and computation. However, this feature may be enabled and used
> independently, as is.
> 

Please use the common clock framework for this part. You will need a
dummy userspace user for this to work but I know Stephen is open to that
as we discussed that use case multiple times already.

> The patches 3 and 4 enable the XT calibration feature per se. The SQW
> output must be enabled for usage of this feature.

Please use the .set_offset and .get_offset rtc_ops for this part.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
