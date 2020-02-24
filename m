Return-Path: <SRS0=fJJe=4M=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6AFC11D24
	for <linux-rtc@archiver.kernel.org>; Mon, 24 Feb 2020 07:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA892072D
	for <linux-rtc@archiver.kernel.org>; Mon, 24 Feb 2020 07:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582529350;
	bh=Gnqx14yTRwF14JXShUphV1zBUOiEnzJ4v/Yu/O4otVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hj2AXl8QA0RSC2U8MNv8kw2dbiAyYWLsHrzrnn2PFjIS2WcV7/V8t4C60Ac2oYdLV
	 0ucqQCJuDx3C2wBM1I9R3h6L3WFkV1WBMUi166j536543BSFhuuJChd0PR7JbynKD3
	 XOtC1AhWb0INdrsJdPZ+R2fLDUJXY0zq8/+FyrfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgBXH3J (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:29:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgBXH3J (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 24 Feb 2020 02:29:09 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79AEF20578;
        Mon, 24 Feb 2020 07:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582529348;
        bh=Gnqx14yTRwF14JXShUphV1zBUOiEnzJ4v/Yu/O4otVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o4raHuSDRrrN4hycZ2fZjLGpipgS6luIi+bzx9TUMEFx/+Btdl2OSwJGUhNRyxCDh
         7d5yDOQ0CKd+DhqJE40GkwMStnuYi+8FS1+/EOwOKZonfMrWaQSGWcwgezwfmFiXtW
         LOtPle8gNh2fwWDsuqWO3V+RTS8KI/iByU/bGj9Q=
Date:   Mon, 24 Feb 2020 15:28:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 5/8] firmware: imx: Align imx_sc_msg_req_cpu_start to 4
Message-ID: <20200224072858.GV27688@dragon>
References: <cover.1582216144.git.leonard.crestez@nxp.com>
 <a74fdf9dd976a6b3198844880ec2f4c6f1c70dca.1582216144.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a74fdf9dd976a6b3198844880ec2f4c6f1c70dca.1582216144.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, Feb 20, 2020 at 06:29:36PM +0200, Leonard Crestez wrote:
> The imx SC api strongly assumes that messages are composed out of
> 4-bytes words but some of our message structs have odd sizeofs.
> 
> This produces many oopses with CONFIG_KASAN=y.
> 
> Fix by marking with __aligned(4).
> 
> Fixes: d90bf296ae18 ("firmware: imx: Add support to start/stop a CPU")
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
