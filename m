Return-Path: <SRS0=TnKn=MX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217C4C32788
	for <linux-rtc@archiver.kernel.org>; Thu, 11 Oct 2018 07:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D182E20841
	for <linux-rtc@archiver.kernel.org>; Thu, 11 Oct 2018 07:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D182E20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=innerrange.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeJKOeO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:34:14 -0400
Received: from mail.innerrange.com.au ([203.222.77.226]:39874 "EHLO
        mail.innerrange.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeJKOeO (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 11 Oct 2018 10:34:14 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2018 10:34:13 EDT
Received: from ir-mail.corp.innerrange.com.au (192.168.4.15) by
 ir-mail.corp.innerrange.com.au (192.168.4.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 11 Oct 2018 17:53:15 +1100
Received: from ir-mail.corp.innerrange.com.au ([fe80::b00d:e485:459b:788f]) by
 ir-mail.corp.innerrange.com.au ([fe80::b00d:e485:459b:788f%2]) with mapi id
 15.01.1531.007; Thu, 11 Oct 2018 17:53:15 +1100
From:   Craig McQueen <craig.mcqueen@innerrange.com>
To:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: rtc-pcf85063 driver bug in pcf85063_stop_clock()
Thread-Topic: rtc-pcf85063 driver bug in pcf85063_stop_clock()
Thread-Index: AdRhLpAphnxl5ZJFTI2Ul842q9nmWg==
Date:   Thu, 11 Oct 2018 06:53:15 +0000
Message-ID: <7f8c164eb0fd47788ec6bbd34735f4a5@innerrange.com>
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

The function pcf85063_stop_clock() is intended to provide the value of the Control_1 register via the pointer ctrl1.

However, it's really providing the return value of the last i2c_smbus_write_byte_data() call, i.e., zero. So the register value needs to be saved in a separate local variable other than ret. Or, the line *ctrl1 = ret; needs to be moved up to be above the last i2c_smbus_write_byte_data() call.

-- 
Craig McQueen

