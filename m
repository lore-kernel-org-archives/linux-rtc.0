Return-Path: <SRS0=f7de=PW=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D88C43387
	for <linux-rtc@archiver.kernel.org>; Mon, 14 Jan 2019 01:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9485220873
	for <linux-rtc@archiver.kernel.org>; Mon, 14 Jan 2019 01:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547430643;
	bh=m6ukqVAeMd3QJlbMlOumC6vXJAvVBCJqZnm3otoMW38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P8N0VTDGoTxVJK3BrdrMsIqltSwbAN2cdVrL6qPzURioqD0tlijkUL6w0N+whhyWi
	 QlXG0Q1EYpE7DQb2SI3EqCkydGY/ifVqNRGfu4SgEd2D2vQe0hoZlvF6/osU5aL3+M
	 Yo0hHJO1an68cE4sMPDNqYSZZLac+VdMcQ3wG8yA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfANBun (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 13 Jan 2019 20:50:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfANBun (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 13 Jan 2019 20:50:43 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C68520854;
        Mon, 14 Jan 2019 01:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547430642;
        bh=m6ukqVAeMd3QJlbMlOumC6vXJAvVBCJqZnm3otoMW38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0k6qYF4WGvIujeX8PtHXlKKx8cL8G7dxvS9rfVSjMtNIFzt3lE965nJB+G3Bg4Az
         w0OeDA3oRTD6yW3X9SrB8uYyg8S1gLfOiGctActA1DUMXaRdQdQ86h0gsd2lb+M0X9
         kSY/ly9JnaG5Bb0xX3mwPd8RxfYUiazb+dQVrgbU=
Date:   Mon, 14 Jan 2019 09:50:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 4/4] ARM64: dts: imx: add i.MX8QXP system controller
 RTC support
Message-ID: <20190114015019.GH15371@dragon>
References: <1545295872-20169-1-git-send-email-Anson.Huang@nxp.com>
 <1545295872-20169-5-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545295872-20169-5-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, Dec 20, 2018 at 08:56:33AM +0000, Anson Huang wrote:
> Add i.MX8QXP system controller RTC support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Different from arm32 dts patches, we use prefix 'arm64: ...' for arm64
ones.  I fixed it up and applied the patch.

Shawn
