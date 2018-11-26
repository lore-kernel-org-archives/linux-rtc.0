Return-Path: <SRS0=ckHn=OF=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04103C43441
	for <linux-rtc@archiver.kernel.org>; Mon, 26 Nov 2018 00:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DC22084E
	for <linux-rtc@archiver.kernel.org>; Mon, 26 Nov 2018 00:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DC22084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=innerrange.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbeKZLN6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:13:58 -0500
Received: from mail.innerrange.com.au ([203.222.77.226]:63018 "EHLO
        mail.innerrange.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKZLN6 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 26 Nov 2018 06:13:58 -0500
Received: from ir-mail.corp.innerrange.com.au (192.168.4.15) by
 ir-mail.corp.innerrange.com.au (192.168.4.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 26 Nov 2018 11:21:33 +1100
Received: from ir-mail.corp.innerrange.com.au ([fe80::b00d:e485:459b:788f]) by
 ir-mail.corp.innerrange.com.au ([fe80::b00d:e485:459b:788f%2]) with mapi id
 15.01.1531.007; Mon, 26 Nov 2018 11:21:33 +1100
From:   Craig McQueen <craig.mcqueen@innerrange.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: RE: rtc-pcf85063 driver bug in pcf85063_stop_clock()
Thread-Topic: rtc-pcf85063 driver bug in pcf85063_stop_clock()
Thread-Index: AdRhLpAphnxl5ZJFTI2Ul842q9nmWgfLE0kwAQRlQYAALE4r4A==
Date:   Mon, 26 Nov 2018 00:21:33 +0000
Message-ID: <842dba0c522942098b03b71f6d501e67@innerrange.com>
References: <7f8c164eb0fd47788ec6bbd34735f4a5@innerrange.com>
 <4b6b1f5f601f459cb992c37c371ade50@innerrange.com>
 <20181125141041.GC19871@piout.net>
In-Reply-To: <20181125141041.GC19871@piout.net>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.105.91]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Alexandre Belloni wrote:
> 
> Hello,
> 
> On 19/11/2018 22:56:07+0000, Craig McQueen wrote:
> > I wrote:
> > >
> > > The function pcf85063_stop_clock() is intended to provide the value
> > > of the
> > > Control_1 register via the pointer ctrl1.
> > >
> > > However, it's really providing the return value of the last
> > > i2c_smbus_write_byte_data() call, i.e., zero. So the register value
> > > needs to be saved in a separate local variable other than ret. Or,
> > > the line *ctrl1 = ret; needs to be moved up to be above the last
> > > i2c_smbus_write_byte_data() call.
> >
> > I'd like to follow up on this. I could perhaps submit a patch, but I'm not sure
> what is the best fix for this bug. Any recommendations?
> >
> 
> I replied a while ago, isn't that fixed by:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d
> rivers/rtc/rtc-pcf85063.c?id=ec9cf1b7a6af2c0cffaa887351e7c7acced5290e

Thanks, that looks like a fix for the exact problem. I thought I'd checked the master branch for a fix before posting this, but maybe I hadn't fetched the latest that includes that commit.

Sorry I missed your previous reply.

-- 
Craig McQueen

