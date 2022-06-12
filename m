Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43890C433EF
	for <linux-rtc@archiver.kernel.org>; Sun, 12 Jun 2022 09:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiFLJw6 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 12 Jun 2022 05:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiFLJw5 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 12 Jun 2022 05:52:57 -0400
X-Greylist: delayed 597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Jun 2022 02:52:56 PDT
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE1D1A3BA
        for <linux-rtc@vger.kernel.org>; Sun, 12 Jun 2022 02:52:56 -0700 (PDT)
Date:   Sun, 12 Jun 2022 04:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1655026977;
        bh=IQ9prYlA/J6R6f9MDzLadU8e2oAyTtHh3QWFvqikGiM=;
        h=Date:From:To:Message-ID:MIME-Version:Content-Type:
         Content-Disposition:From:Subject:To:Date:Sender:Content-Type:
         Content-Transfer-Encoding:Content-Disposition:Mime-Version:
         Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=CMzxHsX+B6snFcxoNO0n6joRaeBTj2cXH2FcFUdR3KoMFyAOwZL9lD7kz/RJ5V05C
         uXoBnrR18JUGTikNRw+vCLAhvUYPUcEg+sNvqlnzQFHuTmNuCW6jxPbgGPlyHBDFjX
         q910ViQzV7B2df3jhBeRp1LaRE+1XJ6vuHLU5Om+HMz2S29nTX9oaZWTWdD7hEwQ5m
         DQdrbTShRnUp6/x6hyJpRLXAhveaCXsshH1j9LFjNCyykZWZhKooooEC7KvyUaOTGq
         gza5aljj1yDRWhB0jqR/oLnpgaJejpuRMi70maKCYDdUfUl8bRzPO92rJY3mwJ7Qlp
         fuFWtryGfBFYg==
From:   "Marty E. Plummer" <hanetzer@startmail.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, a.zummo@towertech.it
Message-ID: <20220612094253.4rgbp3mcc44nffl6@proprietary-killer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

alexandre.belloni@bootlin.com
Bcc:
Subject: RTC: utility function: days to year/month/days?
Reply-To:

Hello.

I'm currently working on a rtc driver for my soc (HiSilicon Hi3521a, and
at least one other, potentially more), and it stores time in the
following registers:
RTC_10MS_COUNT: 7 bits, 10ms increments
RTC_S_COUNT, 6 bits, 1s increments
RTC_M_COUNT, 6 bits, 1m increments
RTC_H_COUNT, 5 bits, 1h increments
RTC_D_COUNT_L, 8 bits, 1d increments, low bits
RTC_D_COUNT_H, 8 bits, 1d increments, high bits

No months or years. Is there any utility function one could use to
convert 0-65535 days into year/month/days already in the kernel, or is
that something I'll have to roll myself?

Mail receipients taken from ./scripts/get_maintainers.pl -f
drivers/rtc/rtc-core.h, so if I'm pinging someone I shouldn't, my
apologies.

Regards,

Marty Plummer

