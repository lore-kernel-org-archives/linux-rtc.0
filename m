Return-Path: <SRS0=hLTa=QU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BIGNUM_EMAILS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198E2C282C2
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Feb 2019 19:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16AA2083B
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Feb 2019 19:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2aVjnUr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbfBMTnp (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:43:45 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51296 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbfBMTnp (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Feb 2019 14:43:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DJhenA088631;
        Wed, 13 Feb 2019 19:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=MDNowYW8gWtoVHJsQyyzS6MgU5vUeVZcnFQjmaXovz8=;
 b=2aVjnUr+2A1GdNkPbxfx+FMrHhzrfG+MRGsBPq83HYWV4hxmFLYqo66Oi8SvQAxNHltt
 Yh8MqUyxJUFd4eT5Vf+dcoxRQyIqjrOlJznfbeist5e0XSVr5e9VgeroQBaLUTBFXN4S
 9VEM+P5S+H54fQkTMtrJ2aDWvaR3rQs8+Z5kPMl8bwK9+dD6abi32SPeGuUk8M3aBqEH
 Cj7WTKnR8s/zTn3fLOfUVIJRkHoSrfpm7Ix+YJuEuTqEwMaslOK3/kFR0PYQ/o5wiSiF
 YWA4JlFBOb8NghT6rf9wJH/ahCw4nfHC8Beli8/Pd1UoM8wPxK7nVnU9wnLfoBd54DNP 9g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qhrekm3fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 19:43:40 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1DJhdKQ013956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 19:43:39 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1DJhcBo026599;
        Wed, 13 Feb 2019 19:43:39 GMT
Received: from kadam (/41.202.241.28)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 19:43:38 +0000
Date:   Wed, 13 Feb 2019 22:43:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: [bug report] rtc: ds1307: rx8130: honor Voltage Loss Flag when
 reading the time
Message-ID: <20190213193847.GI5458@kadam>
References: <20190213131731.GA29774@kadam>
 <20190213175125.bpwwi2slm6lvjg3x@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190213175125.bpwwi2slm6lvjg3x@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130134
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, Feb 13, 2019 at 06:51:25PM +0100, Uwe Kleine-König wrote:
> Hello Dan,
> 
> On Wed, Feb 13, 2019 at 04:17:31PM +0300, Dan Carpenter wrote:
> > The patch 501f98266cad: "rtc: ds1307: rx8130: honor Voltage Loss Flag
> > when reading the time" from Jan 25, 2019, leads to the following
> > static checker warning:
> > 
> > 	drivers/rtc/rtc-ds1307.c:314 ds1307_set_time()
> > 	warn: this cast is a no-op
> > 
> > drivers/rtc/rtc-ds1307.c
> >     304 	result = regmap_bulk_write(ds1307->regmap, chip->offset, regs,
> >     305 				   sizeof(regs));
> >     306 	if (result) {
> >     307 		dev_err(dev, "%s error %d\n", "write", result);
> >     308 		return result;
> >     309 	}
> >     310 
> >     311 	if (ds1307->type == rx_8130) {
> >     312 		/* clear Voltage Loss Flag as data is available now */
> >     313 		result = regmap_write(ds1307->regmap, RX8130_REG_FLAG,
> > --> 314 				      ~(u8)RX8130_REG_FLAG_VLF);
> >                                                ^^^^^^^^^^^^^^^^^^^^^^^^
> > RX8130_REG_FLAG_VLF is 0x2.  The cast to u8 doesn't change anything
> > because it gets type promoted to int.  I don't know what was intended.
> 
> This reasoning looks right, yes. I don't remember why I added it.
> Probably because I intended to create the value 0xfd and not 0xfffffffd
> (aka -3).
> 
> Feel free to fix this in a patch blaming me.

If it's working as-is then I'm not going to be the one to break it...  :P

regards,
dan carpenter

