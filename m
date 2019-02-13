Return-Path: <SRS0=hLTa=QU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B50C282C2
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Feb 2019 13:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB80B222B1
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Feb 2019 13:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mkJd+hCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390118AbfBMNRs (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:17:48 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53056 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbfBMNRs (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Feb 2019 08:17:48 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DDEHUS134189;
        Wed, 13 Feb 2019 13:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=ORjybhG6exEMfI1m6SJPvOA3Qcr+vl+xkaot0Ooc3YI=;
 b=mkJd+hCso4nWXVAUx+FClkyCmCvwxnFNWZ/AeLkNvzTSDs1cHRsf3MoY3gLct2npCxtm
 Lk6pI+OlJjACH46dMqt01BJfx7VPvsTI7uL2/inWT071BwDFb76NFWJuOjxbK+0Fg1KV
 E1cnnOuuG4NBvp15TG+wMQN/KvqUqOOmVFhffr9AIBFzlRNFUBopOvqsw2SHJYkys7Mx
 iobz99HiQB/mT8N6KkLWXTu4TEEk8Rtl6sTUPQWyg83r4Qctng/o634XvwTo0yAsINLK
 xo6z7Kdk0JThecc2sbDghZed3LdGOlFhF7u2XsJ6EL9Qqc7lzdilol81VpoH1hiKzVxG IQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qhree1wgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 13:17:42 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1DDHfMw025640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 13:17:42 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1DDHfIf015364;
        Wed, 13 Feb 2019 13:17:41 GMT
Received: from kadam (/41.202.241.15)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 13:17:41 +0000
Date:   Wed, 13 Feb 2019 16:17:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     u.kleine-koenig@pengutronix.de
Cc:     linux-rtc@vger.kernel.org
Subject: [bug report] rtc: ds1307: rx8130: honor Voltage Loss Flag when
 reading the time
Message-ID: <20190213131731.GA29774@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=604 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130098
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hello Uwe Kleine-König,

The patch 501f98266cad: "rtc: ds1307: rx8130: honor Voltage Loss Flag
when reading the time" from Jan 25, 2019, leads to the following
static checker warning:

	drivers/rtc/rtc-ds1307.c:314 ds1307_set_time()
	warn: this cast is a no-op

drivers/rtc/rtc-ds1307.c
    304 	result = regmap_bulk_write(ds1307->regmap, chip->offset, regs,
    305 				   sizeof(regs));
    306 	if (result) {
    307 		dev_err(dev, "%s error %d\n", "write", result);
    308 		return result;
    309 	}
    310 
    311 	if (ds1307->type == rx_8130) {
    312 		/* clear Voltage Loss Flag as data is available now */
    313 		result = regmap_write(ds1307->regmap, RX8130_REG_FLAG,
--> 314 				      ~(u8)RX8130_REG_FLAG_VLF);
                                               ^^^^^^^^^^^^^^^^^^^^^^^^
RX8130_REG_FLAG_VLF is 0x2.  The cast to u8 doesn't change anything
because it gets type promoted to int.  I don't know what was intended.

    315 		if (result) {
    316 			dev_err(dev, "%s error %d\n", "write", result);
    317 			return result;
    318 		}
    319 	}
    320 
    321 	return 0;
    322 }

regards,
dan carpenter
