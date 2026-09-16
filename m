Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7944E2F30;
	Wed, 16 Sep 2026 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592610; cv=none; b=sABuiWwxKM/Fs1c7FvNF0/qHvaXacwQhS333pp9zVfgFKXvEWAwLd0/yWZfwc4hHzokk55aB6ceKPkTA6M7k64Ylo/NA3OoJFTvKzeadQnG5sqCRK1I4nt3wRmLx6U3aVPcN4f9MD8ND8eDsjNId0JjKJNp36JgHq2xYOZHGut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592610; c=relaxed/simple;
	bh=eXo5+INcV/f7M+0pIBnqb/hLTkT61Q4q+6PsHNJReJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G1V/etngvaBH/m/ppNXiChm4ujrvxBI9WWX8XiSIySrBSDO6e2pLU4iIWbcdQmCcW0RU1iz3nJKUF/iTP0H67m6t682u+ltGdmv0f4KNNvIRjXcntzGjZyCM3SAGNLCsPBETpkhTxTMwZelTqyBF82AzhK9MXQbE5lkmAbXSrGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LweevrRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LweevrRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177741F000FF;
	Wed, 16 Sep 2026 21:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789592573;
	bh=eXo5+INcV/f7M+0pIBnqb/hLTkT61Q4q+6PsHNJReJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LweevrREQXwwSUdGIu0bICQL5x3+WCOmbTdAdZyfo3nhq5rXk62zAT7b7Z8sYM2Pe
	 mgRw4LBW6ylfw8Ysid7+qolzV5merRdM/oQiB+yBHMUwVKtAXPLuqIyvKHJfMWe1zd
	 JKFusbOWHvDqt6a9Bio2PPSHJInuFmJz/Dz6RbXvNmpagXX+iWgHwjcCzOXWE8feuY
	 nyyYxknOi/47ewZKQG1AyRBtZTIkb1rspkAsfXs3LdBaj7v74fEDhyh19Bi9fJqu3Y
	 tuTOvHKVAS20H6JZLDQXlO67jps/gSmgpaMJ0uiiffj3LYaSECSSSQXMwSjQaoqSub
	 k9bhdXrp2JbEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/9] rtc: abx80x: add mutex protection for register
 writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260916205138.16771-4-apokusinski01@gmail.com>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
 <20260916205138.16771-4-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:02:52 +0000
Message-Id: <20260916210253.177741F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The ABX80X RTC driver performs multi-step register operations such as
> NVMEM transfers or register writes preceded by a configuration key
> write. Add a mutex to serialize all the register writes to protect
> these sequences against race conditions.
>=20
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916205138.1677=
1-1-apokusinski01@gmail.com?part=3D3

