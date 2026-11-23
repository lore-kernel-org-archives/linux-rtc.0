Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795474553;
	b=ea+oU2kV0daJmyeJXOELudDAM7r7cdfJhPjMPjm6Fva4t9KJhoZsFzxL+LkPZzjIIaeJ
	 GOndpAbVG2waBs+umgMaSWHq+ODtNpKN1LTfy+OSP4gdyu4farkWMNJONklX8maroT1qt
	 gPFKHa3VvgSea+QvrI1BKElRxE92s4QgkcaO4SQz7Ui1a9+7AOBE6So2CafL1SNFASJgq
	 u0O1llnHnvz89X+e71vWCSdgoK1ratkuPsU8fXRNx1tUuxfkJZ5zMsF2uXj89mqP7AcfL
	 JH+Yo0gLbGZpJK20nIcmvdCjPXJ1PgbVhvUfrqwzseD4bjAkJptLzeyAKZJd2i/aO7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474553;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HfMY6/O3zRpxCQSfkJKjjgFUMEZl0LbeUBv6c+erTNk=;
	b=NzunWsFVOonIj7LBrwyCJriCYCd1zqLSyxqiInU85enABhn3a78smRbtb6lxPRTGdcNE
	 4ahM2ucWR4A8gEGq9wqsGvRb1ZQzXmnSvB3GdE41Zx2N6hG/IpxkVHI8QuTY16x0Difjr
	 f2u4s5/dQoqVozHgJYWoboKRQLeP0oIQKlT2jV/zgQbZr8woF8TIaUrInowTsHnow7hT+
	 kYPi2AZvbmpc8bT8g8CgwsSJlxx08n2xPRo4Laan7q+4JPpM9x2UOy6hxApzXz+7BE9np
	 FGz/SoLvv/ywnw5k7cSsryhXBTmXT0ketvJy8GvDMXXf1O9QiQhu29xiJzUmCcMcB4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqEPhokq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CE5606A31E
	for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 22:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqEPhokq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD451F000D2;
	Mon, 23 Nov 2026 22:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795474552;
	bh=HfMY6/O3zRpxCQSfkJKjjgFUMEZl0LbeUBv6c+erTNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iqEPhokq8zMnkIyBPRZBIQvBsHZl/8xHfctOBz/jDcjWcT3aq++STanR7Qu/w3jMh
	 inW62iOT7MCy631aEInV/JkYIxPu1PeMtwV9tAEOsXlb5f8mAtlqz6N9DHBz7lYXWC
	 ybBceTp1N6Lh683ZRMwg+gZ/T0noYDaDAd5nI/pb+ZgNCZ9MJGRF+gts78/7iRmhDr
	 N1hyP6Ra7tGO7rtqlTFwsRJtcMcOYwTS+zYhuL4Kv8btmRUN0r+eb8lqp0JZuID2gC
	 Z7MuF6GHVkuQ6kItwtz85zSwumbQlad0Qa43pwwQW/RndPGdJB05ixT5USlBRCbuhX
	 45AcCvSqRQ5VA==
Message-ID: <sashiko-outbox-230172@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 0/3] rtc: Add Cortina Systems CS7542 calendar clock
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261124-b4-cs7542-rtc-v4-0-bceefd844074@gmail.com>
References: <20261124-b4-cs7542-rtc-v4-0-bceefd844074@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 22:55:52 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 3-patch series:

- Patches 1 and 2: no issues found.
- Patch 3: skipped (not reviewed).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-b4-cs7542-=
rtc-v4-0-bceefd844074@gmail.com
