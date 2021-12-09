Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C791C433F5
	for <linux-rtc@archiver.kernel.org>; Thu,  9 Dec 2021 19:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhLITzo (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:55:44 -0500
Received: from mail.hugovil.com ([162.243.120.170]:46688 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhLITzo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 9 Dec 2021 14:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ww0JTX4rkmb11KBUNzaX4AtPLZ+R+bgJBGMPHbzLzYQ=; b=u5eVIvWFsMBMF9Ukt+kAMl2kjB
        PXcHLQFewoO68OsCpsTZlz7Qb+A8jNd8zIaqER6kwdG3bDF7X7MFBCDO2bA1eXU2JxJu/xF1d0Pe8
        9h4TX4/LG9MAtwIBy4XqQ9Y5Ewgvom46s1cVllfnXKl8dr29dgbWeYYHjbBnfNwuE1BY=;
Received: from ipagstaticip-ad9375f2-382c-b511-8ac1-9541f69fe50f.sdsl.bell.ca ([142.116.33.166]:19006 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1mvPSa-0003Mh-5j; Thu, 09 Dec 2021 14:52:09 -0500
Date:   Thu, 9 Dec 2021 14:52:07 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        r.cerrato@til-technologies.fr
Message-Id: <20211209145207.30ee844655c553a5c20d9249@hugovil.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 142.116.33.166
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Inquiry about new RTC driver PCF2131
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,
I am currently developping a new RTC driver for the NXP PCF2131 chip.

This RTC is very similar in functionality to the PCF2127/29.

Basically it:
  -supports two new control registers at offsets 4 and 5
  -supports a new reset register
  -supports 4 tamper detection functions instead of 1
  -has no nvmem (like the PCF2129)
  -has two output interrupt pins

Because of that, most of the register addresses are very different, although they still follow the same layout. For example, the tamper registers have a different base address, but the offsets are all the same.

I would like to modify the existing PCF2127 driver to add support for this new RTC, instead of simply copying (forking) the PCF2127 driver. I think that it would ease the maintenance in the long term.

I am curious to hear the RTC maintainers view on that proposition.

Here is a link to the datasheets of the two chips:

    https://www.nxp.com/docs/en/data-sheet/PCF2131DS.pdf
    https://www.nxp.com/docs/en/data-sheet/PCF2127.pdf

Thank you,
Hugo V.

-- 
Hugo Villeneuve <hugo@hugovil.com>
