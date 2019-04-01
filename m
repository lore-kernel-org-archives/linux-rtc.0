Return-Path: <SRS0=n38N=SD=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3C9C43381
	for <linux-rtc@archiver.kernel.org>; Mon,  1 Apr 2019 17:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF82208E4
	for <linux-rtc@archiver.kernel.org>; Mon,  1 Apr 2019 17:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbfDARwu (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:52:50 -0400
Received: from muru.com ([72.249.23.125]:43806 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732539AbfDARwt (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 1 Apr 2019 13:52:49 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9D80080C0;
        Mon,  1 Apr 2019 17:53:02 +0000 (UTC)
Date:   Mon, 1 Apr 2019 10:52:45 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        t-kristo@ti.com, ssantosh@kernel.org, d-gerlach@ti.com,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 3/5] arm: mach-omap2: pm33xx: Add support for rtc+ddr in
 self refresh mode
Message-ID: <20190401175245.GJ49658@atomide.com>
References: <20190322171619.4180-1-j-keerthy@ti.com>
 <20190322171619.4180-4-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322171619.4180-4-j-keerthy@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

* Keerthy <j-keerthy@ti.com> [190322 17:16]:
> +static int am43xx_check_off_mode_enable(void)
> +{
> +	/*
> +	 * Check for am437x-sk-evm which due to HW design cannot support
> +	 * this mode reliably.
> +	 */
> +	if (of_machine_is_compatible("ti,am437x-sk-evm") && enable_off_mode) {
> +		pr_warn("WARNING: This platform does not support off-mode, entering DeepSleep suspend.\n");
> +		return 0;
> +	}
> +
> +	return enable_off_mode;
> +}

Considering off-mode suspend depends on how the board is
wired for various things such as memory, PMIC and the related
signal lines, I agree using the machine compatible is the best
check we can do here.

But since the device can hang during suspend unless things are
configured right for the board, I suggest you rather list allowed
boards here that are known to work with off-mode.

Otherwise many out-of-tree boards might hang during suspend
mysteriously.

Regards,

Tony
