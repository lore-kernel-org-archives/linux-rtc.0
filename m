Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0633C433DB
	for <linux-rtc@archiver.kernel.org>; Thu, 28 Jan 2021 10:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B7760235
	for <linux-rtc@archiver.kernel.org>; Thu, 28 Jan 2021 10:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhA1KVw (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 28 Jan 2021 05:21:52 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:44671 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231467AbhA1KVp (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 28 Jan 2021 05:21:45 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0508358078E;
        Thu, 28 Jan 2021 05:20:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 28 Jan 2021 05:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=CRTbXfYqvKWX3kel+Vs7SqRwF7f
        OlDjsuYHVRUyeCgk=; b=GIIdik2Osy/HhZsywf3vX/nRSBZJWHTnGGcXaQMLe1y
        cnrLgPq511VVzDgPONvt11VyiaK4fIOc8AvYiAm0qFKNhjbCbgVkq6JDYdUTjZ6B
        B2KxIP7IF1+0YaP8EACI+GeXwQ9cwFJlt0HtTfYGknD2zHRd6VU2G3CldkYl97hJ
        y0Akm19earaH7fzAmMSafryq8v/ZNdh/KKy3B51L41U952jKXnX6a57gIqqiKaRR
        1rwhZxnAQ2+tqljOtVa3+qAneetYMsLsDE/BL0z8dGfencleCdISDnp3/WCzyZfo
        ALgPuHrJ/uB92gKR4ZWLz8e6rnxU5IFd3nkuyVtglCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=CRTbXf
        YqvKWX3kel+Vs7SqRwF7fOlDjsuYHVRUyeCgk=; b=HuxbcbrFVRexXJigy/yQuG
        4cPx3liYHAUmEr4DmbzTnCDmIjweRrWkMpWmFLaauPK9qGxv84l16wTpkjq4rQRF
        T7RVLgQML6iRrAgPss60mojJMwaILM6GHMGSY2Phri67X6Re531BEeOqxrMIOkte
        vaHTpFqABWMaCIMix/lj3zmwrbnO0PahrMvCYzUnSXAJVRHaQbIj0V/EfH6PGXuT
        zGHrO3u1LDOVwKOawUPFs6VHmtmQ2EwmqcXcWKw55mTKjgbaz1INPhlVBITr4VfM
        bvgrC0kFXaVSvAi3CVLTm3hTak8ggRgcTtQPLf/EXFZbGHbZAjxKspyuZwNIbopw
        ==
X-ME-Sender: <xms:CZASYLxwR9Ix6N83sXoZyTNmJZUB4VHb57c5LJuU1nIewspx52mGgQ>
    <xme:CZASYDfeTOFzy9RL_N-egyeQ-tSdK0OXZ1lCaIblNUJ2ztnvjVoTlbnG6fNcN3pPx
    AUDNzy6PAuRBwBGo6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:CZASYHJQ7rHU0WzX1AczKxK5MbLwPAsEwj2TL2l4m3DS_tTOovaHDQ>
    <xmx:CZASYEEqnc3f4cW4mAQTx0alIV-Q2a-IWiCCpmrccXder6qWNZdCdA>
    <xmx:CZASYBpPZa8iD8GZ6qZahS036Rtgn8Kt5vhExlXkry0nIh3IImSGWA>
    <xmx:CpASYMn8l25_GBW84wzcQFIaNTbozh3kyuBxvjq_47rGWK3pfsbSXw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 57826108005F;
        Thu, 28 Jan 2021 05:20:57 -0500 (EST)
Date:   Thu, 28 Jan 2021 11:20:56 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v5 12/20] dt-bindings: rtc: sun6i: Add H616 compatible
 string
Message-ID: <20210128102056.x4c2uaxcwsrvoytx@gilmour>
References: <20210127172500.13356-1-andre.przywara@arm.com>
 <20210127172500.13356-13-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="curbrw5osjzzvr6w"
Content-Disposition: inline
In-Reply-To: <20210127172500.13356-13-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org


--curbrw5osjzzvr6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2021 at 05:24:52PM +0000, Andre Przywara wrote:
> Add the obvious compatible name to the existing RTC binding, and pair
> it with the existing H6 fallback compatible string, as the devices are
> compatible.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

maxime

--curbrw5osjzzvr6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBKQBwAKCRDj7w1vZxhR
xaHIAP9KN+jjyAubOGQwD7yj/7RXCjNlFSCjG7LtNiWtYNPkBgD+Oitnci5gG2Gm
t/e0gXDcs9EM0zfZajBtr83FXHZwqwk=
=7H6K
-----END PGP SIGNATURE-----

--curbrw5osjzzvr6w--
